Time _time;
_time.setBpm(160);

MidiIn midi1;
MidiIn midi2;
MidiMsg msg1;
MidiMsg msg2;

if (midi1.open(1) == false) me.exit();
<<< "midi1 device", midi1.name(), "ready" >>>;

if (midi2.open(1) == false) me.exit();
<<< "midi2 device", midi2.name(), "ready" >>>;

Wacko wacko => LPF lpf => Gain master => dac;
0.5 => master.gain;

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
filtFmFreq.set(5, 127, 1, 127, 40);
filtFmModRange.set(   6, 127,   2, 127,   300 );
filtFmModOffset.set(  7, 127,   3, 127,   200 );

KnobSet filtCut;
filtCut.set(8, 127, 4, 127, 60);



while(true) {

  midi1.recv(msg1);
  midi2.recv(msg2);

  <<<msg1.data2, msg2.data2>>>;

  filtFmFreq.getValMult(msg1) => wacko.filterFmFreq;
  filtFmModRange.getValMult(msg1) => wacko.filtFmRange;
  filtFmModOffset.getValMult(msg1) => wacko.filtFmOffset;
  filtCut.getValMult(msg1) => lpf.freq;
  1::samp => now;

}
