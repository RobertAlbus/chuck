TriOsc s => dac;

60 => int C4;

0 => int i;

while (i < 4){

  for ( 100 => int i; i < 110; 2 +=> i ){
    Std.mtof(i) => s.freq;
    0.1::second => now;
  }
  i++;
}

