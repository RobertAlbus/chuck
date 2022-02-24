Time2 _time;
_time.setBpm(144);


MidiIn midi;
MidiMsg msg;
"Midi Through Port-0" => string midiThrough;
"Axiom A.I.R. Mini32" => string axiom;
if (midi.open(axiom) == false) me.exit();
<<< "midi device", midi.name(), "ready" >>>;

SinOsc osc => dac;
LfoController lfo => Gain lfoCatcher => blackhole;
lfo.set(0.4::_time.beat, 200, 20);


////////
// PLAY
0 => int isMidiTestMode;
0::_time.measure => _time.playbackOffset;
16.25 => float finalMeasure;
while(_time.currentMeasure() < finalMeasure) {
  midi.recv(msg);

  if(isMidiTestMode) {
    <<<"MIDI test mode">>>;
    <<<msg.data1,msg.data2,msg.data3>>>;
    midi=>now;
  } else {
    lfo.getVal() => osc.freq;
    if (_time.currentBeat() % 1 == 0) {
      lfo.retrigger();
    }

    samp=>now;
  }

}
