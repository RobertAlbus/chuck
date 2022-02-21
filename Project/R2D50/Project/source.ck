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
0.7 => bassChannel.gain;
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

StepSequencerPatternManager stsq_kick;
StepSequencerPatternManager stsq_hat;
StepSequencerPatternManager stsq_bass;

stsq_kick.init(
  [kick $ Instrument],
  [48.0,50,52,51], 0, _patterns.kickTriggerPatterns,
  [49.0], 0, _patterns.kickNotePatterns
);
stsq_hat.init(
  [hats $ Instrument],
  [65.0,67,69,71], 0, _patterns.hatTriggerPatterns,
  [66.0], 0, _patterns.hatNotePatterns
);
stsq_bass.init(
  [bass $ Instrument],
  [54.0,56,58], 0, _patterns.bassTriggerPatterns,
  [53.0,55,57], 0, _patterns.bassNotePatterns
);

// TODO convert to new meta step sequencer
// will have to find a convenient way to chain each voice's stsq together
// could add a method "chain" that takes an array of of StepSequencerPatternManagers
// and keeps a copy of the references locally then pass all calls through to all chained instances
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

-1 => int _; // pass 
[
//[       T N   T N   T N   T N]
//[msr    Kick  Bass  Hat   Pad]
  [0.0,    _,_,  _,_,  3,_,  _,_],
  [2.0,    _,_,  _,_,  0,_,  _,_],
  [5.0,    _,_,  _,1,  _,_,  _,_],
  [6.0,    _,_,  _,_,  1,_,  _,_],
  [7.0,    _,_,  _,_,  2,_,  _,_],
  [8.0,    _,_,  _,2,  0,_,  _,_],
  [16.0,   3,_,  2,_,  3,_,  _,_]
] @=> float arrangement[][];

////////
// PLAY
0 => int isMidiTestMode;
0::_time.measure => _time.playbackOffset;
12.0 => float finalMeasure;
while(_time.currentMeasure() < finalMeasure) {
  midi.recv(msg);

  if(isMidiTestMode) {
    <<<"MIDI test mode">>>;
    <<<msg.data1,msg.data2,msg.data3>>>;
    midi=>now;
  } else {
    stsq_kick.update(msg);
    stsq_hat.update(msg);
    stsq_bass.update(msg);

    // can also perhaps aggregate each arrangement step into a custom
    // class that includes the stsq to reduce the per-instrument boilerplate

    // optimize by running the for-loop 2x per measure instead of every sample
    if (_time.currentMeasure() % .5 == 0) {

      for (0 => int i; i < arrangement.size(); i++) {
        if (_time.currentMeasure() == arrangement[i][0]) {
          if (arrangement[i][1] >= 0) {
            stsq_kick.setTriggerPattern(arrangement[i][1] $ int);
          }
          if (arrangement[i][2] >= 0) {
            stsq_kick.setNotePattern   (arrangement[i][2] $ int);
          }
          if (arrangement[i][3] >= 0) {
            stsq_bass.setTriggerPattern(arrangement[i][3] $ int);
          }
          if (arrangement[i][4] >= 0) {
            stsq_bass.setNotePattern   (arrangement[i][4] $ int);
    }
          if (arrangement[i][5] >= 0) {
            stsq_hat .setTriggerPattern(arrangement[i][5] $ int);
    }
          if (arrangement[i][6] >= 0) {
            stsq_hat .setNotePattern   (arrangement[i][6] $ int);
    }
    }
    }

    }

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
