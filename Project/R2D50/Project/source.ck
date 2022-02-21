Time2 _time;
_time.setBpm(144);

MidiScales _scales;
MidiChords _chords;
Array2D _array2d;
PatternsR2D49 _patterns;
PresetsR2D49 _presets; 


MidiIn midi;
MidiMsg msg;
"Midi Through Port-0" => string midiThrough;
"Axiom A.I.R. Mini32" => string axiom;
if (midi.open(axiom) == false) me.exit();
<<< "midi device", midi.name(), "ready" >>>;

Gain master => dac;

HH808 hats => Gain hatChannel => Gain hatToggle => master;
Kick kick => HPF kickHpf => Gain kickChannel => master;
OscSynthSingle bass => HPF bassHpf => Gain bassChannel => master;
OscSynthSingle lead => Gain leadChannel => master;
[
  new OscSynthSingle,
  new OscSynthSingle,
  new OscSynthSingle,
  new OscSynthSingle
] @=> OscSynthSingle chordVoices[];

Gain chordSum => Gain chordChannel => master;
for (0 => int i; i < chordVoices.size(); i++) {
  chordVoices[i] => chordSum;
}
1.0 / chordVoices.size() => chordSum.gain;

// FILTERS
30 => float hpfMin;
hpfMin => kickHpf.freq;
hpfMin => bassHpf.freq;

// MIXER GAIN
1 => kickChannel.gain;
1 => bassChannel.gain;
0.25 => hatChannel.gain;
0.4 => chordChannel.gain;

0.8 => master.gain;

////////
// SYNTH PATCHES
kick => _presets.kick;
hats => _presets.hats;
bass => _presets.pluck;
lead => _presets.pluck;

for (0 => int i; i < chordVoices.size(); i++) {
  chordVoices[i] => _presets.pad;
}

////////
// STSQ

StepSequencer stsq_kick;
StepSequencer stsq_hat;
StepSequencer stsq_bass;
[kick $ Instrument] @=> stsq_kick.instruments;
[hats $ Instrument] @=> stsq_hat.instruments;
[bass $ Instrument] @=> stsq_bass.instruments;

StepSequencer stsq_chord[0];
stsq_chord << new StepSequencer << new StepSequencer << new StepSequencer << new StepSequencer;

for(0 => int i; i < stsq_chord.size(); i++) {
  [chordVoices[i] $ Instrument] @=> stsq_chord[i].instruments;
}

// chords[] axis change
_patterns.chordProgression => _array2d.transpose @=> _patterns.chordProgression;

for ( 0 => int i; i < _patterns.chordProgression.size(); i++) {
  _patterns.chordProgression[i] @=> stsq_chord[i].noteSteps;
  _patterns.chordTriggerPatterns[0] @=> stsq_chord[i].triggerSteps;
}


////////
// ARRANGEMENT TOOLS

// KNOBS
KnobScaled kickHpfKnob;
KnobScaled bassHpfKnob;
KnobScaled bassLpfEnvAmount;
kickHpfKnob.set(5, 1000, hpfMin);
bassHpfKnob.set(2, 400, hpfMin);
bassLpfEnvAmount.set(6, 4000, 100);

// PATTERN TOGGLERS
KeyIndexer kickTriggerPatternSelector;
KeyIndexer kickNotePatternSelector;
KeyIndexer bassTriggerPatternSelector;
KeyIndexer bassNotePatternSelector;
KeyIndexer hatTriggerPatternSelector;
KeyIndexer hatNotePatternSelector;

kickTriggerPatternSelector.set([48.0,50,52, 51], 0);
kickNotePatternSelector.set([49.0], 0);

bassTriggerPatternSelector.set([54.0,56,58], 0);
bassNotePatternSelector.set([53.0,55,57], 0);

hatTriggerPatternSelector.set([65.0,67,69,71], 0);
hatNotePatternSelector.set([66.0], 0);


////////
// PLAY
0 => int isMidiTestMode;
0::_time.measure => _time.playbackOffset;
while(true) {
  midi.recv(msg);

  if(isMidiTestMode) {
    <<<msg.data1,msg.data2,msg.data3>>>;
    midi=>now;
  } else {


    if (_time.currentMeasure() == 0.0) {
      hatTriggerPatternSelector.set(3);
    }
    if (_time.currentMeasure() == 2.0) {
      hatTriggerPatternSelector.set(0);
    }
    if (_time.currentMeasure() == 4.0) {
      bassNotePatternSelector.set(1);
    }
    if (_time.currentMeasure() == 6.0) {
      hatTriggerPatternSelector.set(1);
    }
    if (_time.currentMeasure() == 7.0) {
      hatTriggerPatternSelector.set(2);
    }
    if (_time.currentMeasure() == 8.0) {
      hatTriggerPatternSelector.set(0);
      bassNotePatternSelector.set(2);
    }

    kickTriggerPatternSelector.getVal(msg) => int kickTriggerPatternIndex;
    _pattern.kickTriggerPatterns[kickTriggerPatternIndex] @=> stsq_kick.triggerSteps;
    kickNotePatternSelector.getVal(msg) => int kickNotePatternIndex;
    _pattern.kickNotePatterns[kickNotePatternIndex] @=> stsq_kick.noteSteps;

    bassTriggerPatternSelector.getVal(msg) => int bassTriggerPatternIndex;
    _pattern.bassTriggerPatterns[bassTriggerPatternIndex] @=> stsq_bass.triggerSteps;
    bassNotePatternSelector.getVal(msg) => int bassNotePatternIndex;
    _pattern.bassNotePatterns[bassNotePatternIndex] @=> stsq_bass.noteSteps;

    hatTriggerPatternSelector.getVal(msg) => int hatTriggerPatternIndex;
    _pattern.hatTriggerPatterns[hatTriggerPatternIndex] @=> stsq_hat.triggerSteps;
    hatNotePatternSelector.getVal(msg) => int hatNotePatternIndex;
    _pattern.hatNotePatterns[hatNotePatternIndex] @=> stsq_hat.noteSteps;

    kickHpfKnob.getVal(msg) => kickHpf.freq;
    bassHpfKnob.getVal(msg) => bassHpf.freq;
    bassLpfEnvAmount.getVal(msg) => bass.adsrLpfCutoffAmount;

    (now/1::_time.quat) => float currentStep;
    if (currentStep % 1.00 == 0) {
      stsq_hat.play(currentStep $int);
      stsq_kick.play(currentStep $int);
      stsq_bass.play(currentStep $int);

      for(0 => int i; i < stsq_chord.size(); i++) {
        stsq_chord[i].play(currentStep $int);
      }
    }

    samp=>now;
  }

}
