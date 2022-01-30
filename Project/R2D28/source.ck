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
filtFmFreq.set(1, 127, 40, 1, 5);




while(true) {

  midi.recv(msg);
  // <<< msg.data1, msg.data2, msg.data3>>>;

  filtFmFreq.getVal(msg) => wacko.filterFM.freq;
  <<<filtFmFreq.getVal(msg)>>>;
  1::samp => now;

}
