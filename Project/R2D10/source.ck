Time _time;
_time.setBpm(100);

MidiNotes _notes;
MidiScales _scales;
LibR2D9 _lib9;
LibR2D10 _lib10;

////////
// SOUND NETWORK
// Osc oscs[0]
_lib10.create.Oscs(4)  @=> Osc oscs[];
_lib10.create.ADSRs(4) @=> ADSR envs[];

Gain master => dac;
0.4 => master.gain;

////////
// ENVELOPE TIMING
0.5::_time.quat => dur A;
0.75::_time.quat => dur D;
0.6 => float S;
0.5::_time.quat => dur R;

for (0 => int i; i < oscs.size(); i++) {
  envs[i] $ ADSR @=> ADSR env;
  oscs[i] @=> Osc oscillator;
  oscillator => env;
  0.1 => oscillator.gain;
  0   => oscillator.freq;
  
  env => master;
  env.set(A,D,S,R);
}

////////
// STEP SEQUENCER INIT
_lib10.create.STSQ_Ps(4) @=> StepSequencerPitch stsqs_p[];
_lib10.create.STSQ_Es(4) @=> StepSequencerEnv   stsqs_e[];

// LINK TO STSQ
for (0 => int i; i < stsqs_p.size(); i++){
  oscs[i]            @=> Osc      oscillator;
  envs[i] $ Envelope @=> Envelope envelope;
  stsqs_p[i] @=> StepSequencerPitch stsq_p;
  stsqs_e[i] @=> StepSequencerEnv   stsq_e;

  // Attach oscs to pitch step sequencers
  [oscillator] @=> stsq_p.oscs;
  // do not transpose
  0 => stsq_p.baseNote;

  // Attach envelopes to envelope step sequencer
  [envelope] @=> stsq_e.envs;
}

////////
// CHORDS

_notes.Gs3 => int note;
[ note, note+7, note+2] @=> int tonics[];
[ 0, 4, 1] @=> int modes[];
_scales.heptoniaPrima @=> int toneSpace[];
// int scales[0][0];
_lib10.create.scales(tonics, modes, toneSpace) @=> int scales[][];


int chordProgressions[0][0][0];
for(0 => int i; i < scales.size(); i++){
  scales[i].popBack();
  chordProgressions << _lib9.getChords(scales[i]);
}

_lib9.print2dArray(chordProgressions[0]);

_time.bar => dur arrangementUnit;
[
  [0::arrangementUnit, 2::arrangementUnit],
  [2::arrangementUnit, 4::arrangementUnit],
  [4::arrangementUnit, 6::arrangementUnit]
] @=> dur sectionTriggers[][];


0 => int currentBar;


////////
// MAIN ARRANGEMENT LOOP
for (0 => int i; i < sectionTriggers.size(); i++){
  sectionTriggers[i][0] => dur start;
  sectionTriggers[i][1] => dur end;
  
  chordProgressions[i]  @=> int chordProgression[][];
  
  chordProgressions[i+1]  @=> int nextChordProgression[][];
  _lib9.setSteps(stsqs_p, stsqs_e, chordProgression);
  while ( now/arrangementUnit >= start/arrangementUnit && now/arrangementUnit < end/arrangementUnit) {

    if (_time.isStartOfUnit(_time.bar)){
          <<< now / _time.bar >>>;
      _time.currentUnit(_time.quat) => int step;
    }

    if (_time.isStartOfUnit(_time.quat)){
      _time.currentUnit(_time.quat) => int step;

      for (0 => int i; i < stsqs_p.size(); i++){
        stsqs_p[i].play(step);
        stsqs_e[i].play(step);
      }
    }

    if (_lib10.isFinalSampleOf(end) && (nextChordProgression != null)) {
      _lib9.setSteps(stsqs_p, stsqs_e, nextChordProgression);
    }
    _time.advance();
  }
}

// CLOSE OUT
for (0 => int i; i < stsqs_p.size(); i++){
  stsqs_p[i].off();
  stsqs_e[i].off();
}
_time.advance(R);
