
// BPM
120 => int bpm;
0.5 => float beatLength;
beatLength::second => dur beat;
4::beat => dur bar;
0.25::beat => dur quat;

// DECLARATIONS
293.66 => float D4;
349.23 => float F4;
440.00 => float A4;
523.25 => float C5;
659.25 => float E5;

SinOsc _1 => dac;
SinOsc _3 => dac;
SinOsc _5 => dac;
SinOsc _7 => dac;
SinOsc _9 => dac;

fun void setVol( float gain )
{
  gain => _1.gain;
  gain => _3.gain;
  gain => _5.gain;
  gain => _7.gain;
  gain => _9.gain;
}

fun void printNow() 
{
  <<< "now: ", now / quat >>>;
}

fun void sixBeat() 
{
  printNow();
  setVol(0.2);
  2::quat => now;

  printNow();
  setVol(0);
  1::quat => now;
  
  printNow();
  setVol(0.2);
  2::quat => now;
  
  printNow();
  setVol(0);
  1::quat => now;

  printNow();
  setVol(0.2);
  1::quat => now;

  printNow();
  setVol(0);
  1::quat => now;
}

// ASSIGNMENTS


D4 => _1.freq;
F4 => _3.freq;
A4 => _5.freq;
C5 => _7.freq;
E5 => _9.freq;

// PROGRAM
sixBeat();
sixBeat();
sixBeat();
sixBeat();
