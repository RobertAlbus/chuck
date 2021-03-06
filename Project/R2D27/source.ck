Time _time;
_time.setBpm(160);

Wacko wacko => dac;
wacko => FFT fft;

[40,80,160,320] @=> int freqs[];

-0.3 => wacko.lowerBound;
-0.2 => wacko.upperBound;
freqs[1] => wacko.selector.freq;
freqs[0] => wacko.osc1.freq;
freqs[0] => wacko.osc2.freq;

while(true) {
  Math.random2(10,10000) => int filtFmFreq;
  Math.random2(10,500)   => int filtFmBottom;
  Math.random2(100,800 )  => int filtFmRange;

  <<<filtFmFreq," | ",filtFmBottom," | ",filtFmRange >>>;

  filtFmFreq    => wacko.filterFM.freq;
  filtFmRange   => wacko.filtFmRange;
  filtFmBottom  => wacko.filtFmBottom;

  _time.advance(2::_time.bar);
}