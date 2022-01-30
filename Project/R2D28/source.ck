Time _time;
_time.setBpm(160);

MidiIn midi;
MidiMsg msg;

if (midi.open(1) == false) me.exit();
<<< "midi device", midi.name(), "ready" >>>;

Wacko wacko => dac;
wacko => FFT fft;

[40,80,160,320] @=> int freqs[];

-0.3 => wacko.lowerBound;
-0.2 => wacko.upperBound;
freqs[1] => wacko.selector.freq;
freqs[0] => wacko.osc1.freq;
freqs[0] => wacko.osc2.freq;

// RANGES

KnobSet filtFmFreq;
KnobSet filtFmModRange;
KnobSet filtFmModOffset;
filtFmFreq.set(5, 127, 1, 1, 40);
filtFmModRange.set(   6, 127,   2, 127,   300 );
filtFmModOffset.set(  7, 127,   3, 127,   200 );




while(true) {

  midi.recv(msg);

  filtFmFreq.getVal(msg) => wacko.filterFM.freq;
  filtFmModRange.getValMult(msg) => wacko.filtFmRange;
  filtFmModOffset.getValMult(msg) => wacko.filtFmOffset;
  1::samp => now;

}
