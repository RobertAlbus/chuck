// BPM
160 => float bpm;
60/bpm => float beatLength;
beatLength::second => dur beat;
4::beat => dur bar;
0.25::beat => dur quat;

67 => int basePitch;
[ 2, 5, 9, 2, 5, 9, 2, 5 ] @=> int dMinPitchList[];
0.4 => float arpGain;
-12 => int arpPitchOffset;
0.5 => float kickGain;
-36 => int kickPitchOffset;

TriOsc osc1 => dac;
TriOsc osc2 => dac;
TriOsc osc3 => dac;
0 => osc1.gain;
0 => osc2.gain;
0 => osc3.gain;

TriOsc kick => dac;
0 => kick.gain;

Std.srand(69);


0 => int iterations;

while (now / bar < 8){
  (now / quat) $ int => int masterStep;
  masterStep % 16 => int patternStep;

  dMinPitchList @=> int pitchList[];
  (patternStep % (pitchList.size() - 1)) => int arpNoteIndex;
  basePitch + pitchList[arpNoteIndex] + arpPitchOffset => int arpNote;

  Std.mtof(arpNote) => osc1.freq;
  Std.mtof(arpNote + 0) => osc2.freq;
  Std.mtof(arpNote + 0) => osc3.freq;
  arpGain => osc1.gain;
  arpGain => osc2.gain;
  arpGain => osc3.gain;

  basePitch + pitchList[0] + kickPitchOffset => int kickNote;
  Std.mtof(kickNote) => kick.freq;
  if (patternStep % 4.0 == 0) {
    kickGain => kick.gain;
  }
  if (patternStep % 4.0 > 1) {
    0 => kick.gain;
  }

  1::quat => now;
  iterations++;
}