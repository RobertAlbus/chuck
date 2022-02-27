Time2 _time;
_time.setBpm(144);


MidiIn midi;
MidiMsg msg;
"Midi Through Port-0" => string midiThrough;
"Axiom A.I.R. Mini32" => string axiom;
// if (midi.open(axiom) == false) me.exit();
// <<< "midi device", midi.name(), "ready" >>>;

SqrOsc osc => LPF lpfFilter => dac;
44 => osc.freq;

LfoController lfo => Gain lfoCatcher => blackhole;
lfo.setMinMax(1::_time.beat, 0, 700, "saw");

AutomationEnvelope automationEnvelope;
automationEnvelope.set(0.5);

_time.beat/samp => float beatSamples;
// composition-level automation clip
float envelopeArrangement[0][0];
for (0 => int i; i < 8; i++) {
  envelopeArrangement
    << [(i * 4.0) + 0.00 ,  0.25] // no rate of change specified,
    << [(i * 4.0) + 1.0625 ,  1.00] // will change value immediately
    << [(i * 4.0) + 2.00 ,  0.25, 1 * beatSamples]
    << [(i * 4.0) + 3.00 ,  1.00, 2 * beatSamples]
    ;
}

AutomationClip automatioClip;
automatioClip.set(automationEnvelope, envelopeArrangement, _time.bar);

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
    automatioClip.update();

    automatioClip.getVal()::_time.beat => lfo.rate;
    // (automatioClip.getVal() * 1000) + 400 => lfo.centerVal;
    // (automatioClip.getVal() * 1000) + 350 => lfo.range;

    Math.max(0, lfo.getVal()) => lpfFilter.freq;

    samp=>now;
  }

}
