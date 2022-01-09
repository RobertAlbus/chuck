// BPM
160 => float bpm;
60/bpm => float beatLength;
beatLength::second => dur beat;
4::beat => dur bar;
0.25::beat => dur quat;

[ 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 0 ] @=> int pattern_1[];
[ 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0 ] @=> int pattern_2[];
[ 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0 ] @=> int pattern_3[];
[ 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 1 ] @=> int pattern_4[];
[ 0, 0, 1, 1, 0, 0, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1 ] @=> int pattern_5[];

[ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,-1,-1 ] @=> int bassPitchMod[];

SndBuf kick => dac;
SndBuf oh => dac;
SndBuf snare => dac;
SndBuf stick => dac;

SqrOsc bass => dac;

33 => int bassRootNote;
Std.mtof(bassRootNote) => bass.freq;
0 => bass.gain;
0.3 => float bassGain;

"_audio/kick_01.wav" => kick.read;
0.8 => kick.rate;
"_audio/hihat_03.wav" => oh.read;
0.5 => oh.gain;
0.99 => oh.rate;

"_audio/snare_02.wav" => snare.read;
1.2 => snare.gain;
0.9 => snare.rate;

"_audio/snare_03.wav" => stick.read;
1.2 => stick.gain;
1 => stick.rate;

kick.samples() => kick.pos;
oh.samples() => oh.pos;
snare.samples() => snare.pos;
stick.samples() => stick.pos;

while (now / bar < 4){
  (now / quat) $ int => int masterStep;
  masterStep % 16 => int step;

  if (pattern_1[step]) {
    0 => kick.pos;
    oh.samples() => oh.pos;
  }

  if (pattern_2[step]) {
    0 => oh.pos;
  }

  if (pattern_3[step]) {
    0 => snare.pos;
  } else if (pattern_3[step] - 1 && !(pattern_3[step])) {
    snare.samples() => snare.pos;
  }

  if (pattern_4[step]) {
    0 => stick.pos;
  }

  // bass 
  if (pattern_5[step]) {
    bassGain => bass.gain;
    
  } else {
    0 => bass.gain;
  }
  // bass pitch
  bassRootNote + bassPitchMod[step] => int bassMidiNote;
  Std.mtof(bassMidiNote) => bass.freq;

  1::quat => now;
}
