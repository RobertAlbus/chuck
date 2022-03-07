Time2 _time;
_time.setBpm(144);


MidiIn midi;
MidiMsg msg;
"Midi Through Port-0" => string midiThrough;
"Axiom A.I.R. Mini32" => string axiom;
// if (midi.open(axiom) == false) me.exit();
// <<< "midi device", midi.name(), "ready" >>>;

Mixer mixer;
// panning
1 => float R;
-1 => float L;
0 => float C;

mixer.createChannel(
  "master", 1.00,
  new MasterProcessing,
  [
    mixer.createChannel(
      "drum bus", 0.10,
      new DrumBusProcessing,
      [
        mixer.createChannel("kick", 1.00, new KickProcessing),
        mixer.createChannel("hat",  1.00, new HatProcessing)
      ]
    ),
    mixer.createChannel(
      "bass bus", 0.10,
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
);

mixer.chanOut["master"].outL => dac.left;
mixer.chanOut["master"].outR => dac.right;

// mixer.solo(["kick", "hat", "drum bus", "master"]);

SinOsc kick => mixer.chanIn["kick"].inL;
       kick => mixer.chanIn["kick"].inR;
SinOsc hat  => mixer.chanIn["hat"].inL;
       hat  => mixer.chanIn["hat"].inR;
SinOsc sub  => mixer.chanIn["sub"].inL;
       sub  => mixer.chanIn["sub"].inR;
SinOsc acid => mixer.chanIn["acid"].inL;
       acid => mixer.chanIn["acid"].inR;

Std.mtof(60) => kick.freq;
Std.mtof(63) => hat.freq;
Std.mtof(67) => sub.freq;
Std.mtof(70) => acid.freq;


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
