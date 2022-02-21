Time2 _time;
Time2.setBpm(144);

MidiScales _scales;
MidiChords _chords;
Array2D _array2d;

MidiIn midi;
MidiMsg msg;
"Midi Through Port-0" => string midiThrough;
"Axiom A.I.R. Mini32" => string axiom;
if (midi.open(axiom) == false) me.exit();
<<< "midi device", midi.name(), "ready" >>>;

Gain master => dac;

HH808 hats => Gain hatChannel => Gain hatToggle => master;
Kick kick => HPF kickHpf => Gain kickChannel => Gain kickToggle => master;
OscSynthSingle bass => HPF bassHpf => Gain bassChannel => Gain bassToggle => master;
OscSynthSingle lead => Gain leadChannel => Gain leadToggle => master;
[
  new OscSynthSingle,
  new OscSynthSingle,
  new OscSynthSingle,
  new OscSynthSingle
] @=> OscSynthSingle chordVoices[];

Gain chordSum => Gain chordChannel => Gain chordToggle => master;
for (0 => int i; i < chordVoices.size(); i++) {
  chordVoices[i] => chordSum;
}
1.0 / chordVoices.size() => chordSum.gain;

// FILTERS
30 => float hpfMin;
hpfMin => kickHpf.freq;
hpfMin => bassHpf.freq;

KnobScaled kickHpfKnob;
KnobScaled bassHpfKnob;
KnobScaled bassLpfEnvAmount;
kickHpfKnob.set(5, 1000, hpfMin);
bassHpfKnob.set(2, 400, hpfMin);
bassLpfEnvAmount.set(6, 4000, 100);

// PATTERN TOGGLERS
KeyIndexer bassNotePatternSelector;
bassNotePatternSelector.set([53$float,55,57], 0);

// MIXER GAIN
1 => kickChannel.gain;
1 => bassChannel.gain;
0.25 => hatChannel.gain;
0.4 => chordChannel.gain;

0.8 => master.gain;

////////
// SYNTH PATCHES
PresetsR2D49 presets; 

hats => presets.hats;
bass => presets.pluck;
lead => presets.pluck;

for (0 => int i; i < chordVoices.size(); i++) {
  chordVoices[i] => presets.pad;
}

////////
// STSQ

StepSequencer stsq_k;
StepSequencer stsq_hh;
StepSequencer stsq_bass;
[kick $ Instrument] @=> stsq_k.instruments;
[hats $ Instrument] @=> stsq_hh.instruments;
[bass $ Instrument] @=> stsq_bass.instruments;

StepSequencer stsq_chord[0];
stsq_chord << new StepSequencer << new StepSequencer << new StepSequencer << new StepSequencer;

for(0 => int i; i < stsq_chord.size(); i++) {
  [chordVoices[i] $ Instrument] @=> stsq_chord[i].instruments;
}

// INIT STSQ PATTERNS
PatternsR2D49 pattern;

pattern.kickTriggerPatterns[0] @=> stsq_k.triggerSteps;
pattern.hatTriggerPatterns[0] @=> stsq_hh.triggerSteps;
pattern.bassTriggerPatterns[0] @=> stsq_bass.triggerSteps;

pattern.kickNotePatterns[0] @=> stsq_k.noteSteps;
pattern.hatNotePatterns[0] @=> stsq_hh.noteSteps;
pattern.bassNotePatterns[0] @=> stsq_bass.noteSteps;

// chords[] axis change
pattern.chordProgression => _array2d.transpose @=> pattern.chordProgression;

for ( 0 => int i; i < pattern.chordProgression.size(); i++) {
  pattern.chordProgression[i] @=> stsq_chord[i].noteSteps;
  pattern.chordTriggerPatterns[0] @=> stsq_chord[i].triggerSteps;
}

////////
// ARRANGEMENT TOOLS

fun void toggleInstrument(Gain toggler) {
  if (toggler.gain() == 0 ) {
    1 => toggler.gain;
  } else {
    0 => toggler.gain;
  }
}

fun void toggleKick() {
  toggleInstrument(kickToggle);
}
fun void toggleHat() {
  toggleInstrument(hatToggle);
}
fun void toggleBass() {
  toggleInstrument(bassToggle);
}
fun void toggleChord() {
  toggleInstrument(chordToggle);
}


////////
// PLAY
0 => int isMidiTestMode;
while(true) {
  midi.recv(msg);

  if(isMidiTestMode) {
    <<<msg.data1,msg.data2,msg.data3>>>;
    midi=>now;


  } else {

    msg.data3 > 0 => int hasVelocity;
    msg.data2 => int midiNote;

    if(midiNote == 40 && hasVelocity) {
      toggleKick();
      0 => msg.data3;
    }
    if(midiNote == 41 && hasVelocity) {
      toggleBass();
      0 => msg.data3;
    }
    if(midiNote == 42 && hasVelocity) {
      toggleHat();
      0 => msg.data3;
    }
    if(midiNote == 43 && hasVelocity) {
      toggleChord();
      0 => msg.data3;
    }

    bassNotePatternSelector.getVal(msg) => int bassNotePatternIndex;
    pattern.bassNotePatterns[bassNotePatternIndex] @=> stsq_bass.noteSteps;


    if(midiNote == 60 && hasVelocity) {
      pattern.hatTriggerPatterns[0] @=> stsq_hh.triggerSteps;
      0 => msg.data3;
    }
    if(midiNote == 62 && hasVelocity) {
      pattern.hatTriggerPatterns[1] @=> stsq_hh.triggerSteps;
      0 => msg.data3;
    }
    if(midiNote == 64 && hasVelocity) {
      pattern.hatTriggerPatterns[2] @=> stsq_hh.triggerSteps;
      0 => msg.data3;
    }

    kickHpfKnob.getVal(msg) => kickHpf.freq;
    bassHpfKnob.getVal(msg) => bassHpf.freq;
    bassLpfEnvAmount.getVal(msg) => bass.adsrLpfCutoffAmount;

    (now/1::_time.quat) => float currentStep;
    if (currentStep % 1.00 == 0) {
      stsq_hh.play(currentStep $int);
      stsq_k.play(currentStep $int);
      stsq_bass.play(currentStep $int);

      for(0 => int i; i < stsq_chord.size(); i++) {
        stsq_chord[i].play(currentStep $int);
      }
    }

    samp=>now;
  }

}
