Time2 _time;
_time.setBpm(144);


MidiIn midi;
MidiMsg msg;
"Midi Through Port-0" => string midiThrough;
"Axiom A.I.R. Mini32" => string axiom;
if (midi.open(axiom) == false) me.exit();
<<< "midi device", midi.name(), "ready" >>>;

SqrOsc osc => LPF lpfFilter => dac;
44 => osc.freq;

Envelope env => blackhole;
env.duration(_time.beat);
env.value(0.5);

LfoController lfo => Gain lfoCatcher => blackhole;
lfo.set(1::_time.beat, 350, 400);


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
    Math.max(0, lfo.getVal()) => lpfFilter.freq;
    
    env.value()::_time.beat => lfo.rate;

    if ((now / _time.beat) % 4.0 == 0) {
      env.target(0.25);

    } else if ((now / _time.beat) % 4.0 == 1.5) {
      env.target(2);
    }

    if ((now / samp) % 1000.0 == 0) {
      <<<env.value()>>>;

    }

    samp=>now;
  }

}
