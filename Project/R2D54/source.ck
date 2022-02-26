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

_time.beat/samp => float beatSamples;
// composition-level automation clip
float envelopeArrangement[0][0];
for (0 => int i; i < 8; i++) {
  envelopeArrangement
    << [(i * 4.0) + 0.00 ,  0.25, 1]
    << [(i * 4.0) + 1.25 ,  1.00, 1]
    << [(i * 4.0) + 2.00 ,  0.25, 1 * beatSamples]
    << [(i * 4.0) + 3.00 ,  1.00, 2 * beatSamples]
    ;
}

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

    
    if (_time.currentBar() % 0.25 == 0.0) {
      for (0 => int i; i < envelopeArrangement.size(); i++) {
        envelopeArrangement[i][0]       => float beat;
        envelopeArrangement[i][1]       => float target;
        envelopeArrangement[i][2]::samp => dur   changeRate;

        if(beat == _time.currentBar()) {
          env.duration(changeRate);
          env.target(target);
        }
      }
    } 

    if ((now / samp) % 1000.0 == 0) {
      // <<<env.value()>>>;
    }

    samp=>now;
  }

}
