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

filtfm_freq_knobRange
filtfm_freq_knobOffset
127 => float filtFmFreqRange;
220 => float filtFmFreqOffset;
0 => float filtFmCoarse;
0 => float filtFmFine;
fun void setFiltFmFreq() {
  filtFmCoarse + filtFmFine + filtFmFreqOffset => wacko.filterFM.freq;
  <<<wacko.filterFM.freq()>>>;
}


500 => float filtFmBottomRange;
10 => float filtFmBottomOffset;

800 => float filtFmRangeRange;
100 => float filtFmRangeOffset;



while(true) {

  midi.recv(msg);
  <<< msg.data1, msg.data2, msg.data3>>>;

  if(msg.data2 == 1) { // 1A
    msg.data3/127.0 => filtFmFine;
    setFiltFmFreq();
  }
  // Math.pow(msg.data3, 2) / expRange2 => float logVal;
  if(msg.data2 == 5) { // 1B
    msg.data3 / 127.00 * filtFmFreqRange => filtFmCoarse;
    setFiltFmFreq();
  }
  // if(msg.data2 == 2) {}

  if(msg.data2 == 6) {

  }
    // if(msg.data2 == 3) {}
  if(msg.data2 == 7) {

  }
  // if(msg.data2 == 4) {}
  // if(msg.data2 == 8) {}

  1::samp => now;
  // if(msg.data2 == 8) {}

  // Math.random2(10,10000) => int filtFmFreq;
  // Math.random2(10,500)   => int filtFmBottom;
  // Math.random2(100,800 )  => int filtFmRange;

  // <<<filtFmFreq," | ",filtFmBottom," | ",filtFmRange >>>;


  // _time.advance(2::_time.bar);
}
