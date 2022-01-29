Time _time;
_time.setBpm(160);

Wacko wacko => dac;

[40,80,160,320] @=> int freqs[];

while(true) {

  Math.random2f(-1,1) => wacko.lowerBound;
  Math.random2f(wacko.lowerBound,1) => wacko.upperBound;
  freqs[1] => wacko.selector.freq;
  freqs[0] => wacko.osc1.freq;
  freqs[0] => wacko.osc2.freq;

  _time.advance(1::_time.quat);
}