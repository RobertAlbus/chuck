Time _time;
_time.setBpm(160);

MidiIn midi;
MidiMsg msg;

if (midi.open(1) == false) me.exit();
<<< "midi device", midi.name(), "ready" >>>;

while(true) {
  midi.recv(msg);
  <<< msg.data1, msg.data2, msg.data3,msg.when,now/samp>>>;
  1::samp => now;

}