Time2 _time;
_time.setBpm(144);


MidiIn midi;
MidiMsg msg;
"Midi Through Port-0" => string midiThrough;
"Axiom A.I.R. Mini32" => string axiom;
// if (midi.open(axiom) == false) me.exit();
// <<< "midi device", midi.name(), "ready" >>>;

Mixer mixer;

mixer.createChannel(
  "master", 1.00,
  new MasterProcessing,
  [
    mixer.createChannel(
      "drum bus", 1.00,
      new DrumBusProcessing,
      [
        mixer.createChannel("kick", 1.00, new KickProcessing),
        mixer.createChannel("hat",  1.00, new HatProcessing)
      ]
    ),
    mixer.createChannel(
      "bass bus", 1.00,
      new BassBusProcessing,
      [
        mixer.createChannel("sub",  1.00, new SubProcessing),
        mixer.createChannel("acid", 1.00, new AcidProcessing)
      ]
    ),
    mixer.createChannel(
      "verb plate",  0.00,
      new VerbPlateProcessing,
      [
        mixer.send("acid", 0.4),
        mixer.send("hat",  0.4)
      ]
    )
  ]
) => dac;

SinOsc kick => mixer.chanIn["kick"];
SinOsc hat  => mixer.chanIn["hat"];
SinOsc sub  => mixer.chanIn["sub"];
SinOsc acid => mixer.chanIn["acid"];

Std.mtof(60) => kick.freq;
Std.mtof(63) => hat.freq;
Std.mtof(67) => sub.freq;
Std.mtof(70) => acid.freq;

// for( 0 => int i; i < mixer.keys.size(); i++) {
//   <<<mixer.keys[i]>>>;
// }

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
    mixer.update();
    samp=>now;
  }

}
