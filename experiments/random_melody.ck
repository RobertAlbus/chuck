
// BPM
120 => float bpm;
60/bpm => float beatLength;
beatLength::second => dur beat;
4::beat => dur bar;
0.25::beat => dur quat;

[ 2, 5, 9,     16, 17 ] @=> int dMinPitchList[];
[    5, 9, 12, 16, 17, 19 ] @=> int fMajPitchList[];
fun int[] getPitchList() {
  if ((now / beat) % 8 <= 4) {
    return fMajPitchList;
  } else {
    return dMinPitchList;
  }
}

fun int randNote( int pitchList[] )
{
  Math.random2(0, (pitchList.size() - 1)) => int rand;
  return pitchList[rand];
}
fun int randWeightedBool(int numerator, int denomenator)
{
  Math.random2(0, denomenator) => int rand;
  if( rand <= numerator ){
    return 1;
  } else {
    return 0;
  }
}

TriOsc osc1 => dac;
TriOsc osc2 => dac;
TriOsc osc3 => dac;
0 => osc1.gain;
0 => osc2.gain;
0 => osc3.gain;

TriOsc kick => dac;
0 => kick.gain;

Std.srand(69);
55 => int basePitch;

0 => int iterations;

while (now / bar < 16){
  getPitchList() @=> int pitchList[];
  Std.mtof(basePitch + pitchList[0] - 24) => kick.freq;

  basePitch + randNote(pitchList) => int note1;
  basePitch + randNote(pitchList) => int note2;
  basePitch + randNote(pitchList) => int note3;
  Std.mtof(note1) => osc1.freq;
  Std.mtof(note2 + 0) => osc2.freq;
  Std.mtof(note3 + 0) => osc3.freq;
  if (randWeightedBool(9, 10) == 1) {
    0.3 => osc1.gain;
    0.3 => osc2.gain;
    0.3 => osc3.gain;
  } else {
    0 => osc1.gain;
    0 => osc2.gain;
    0 => osc3.gain;
  }
  if ((now / quat) % 4.0 == 0) {
    0.5 => kick.gain;
  }
  if ((now / quat) % 4.0 > 1) {
    0 => kick.gain;
  }

  1::quat => now;
  iterations++;
}

