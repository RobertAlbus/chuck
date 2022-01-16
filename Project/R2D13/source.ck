// Reference
// https://electro-music.com/forum/topic-31708.html


Time _time;
_time.setBpm(160);

MidiNotes _notes;
MidiScales _scales;

Synth synth;
synth.output => Gain synthChannel => Gain master => dac;
Gain delayChannel => master;
synthChannel => delayChannel;

DelayLine delayLine1;
delayLine1.log("1A");
delayLine1.setTime(3::_time.quat);
delayLine1.log("1B");
delayLine1.output => delayChannel;
delayChannel => delayLine1.input;

DelayLine delayLine2;
delayLine2.log("2A");
delayLine2.setTime(7::_time.quat);
delayLine2.log("2B");
delayLine2.output => delayChannel;
delayChannel => delayLine2.input;

0.42 => float feedbackAmount;
feedbackAmount => delayLine1.output.gain;
feedbackAmount => delayLine2.output.gain;

0.05 => master.gain;
while(true) {
  synth.adsr.keyOn();
  _time.advance(1::_time.beat);
  synth.adsr.keyOff();
  _time.advance(7::_time.beat);

}











// while(now / _time.bar < 8 )
// {
//   if (_time.isStartOfUnit(_time.quat)){
//     _time.currentUnit(_time.quat) => int step;

//     if (step % 4 == 0) {

//     }
//     if (step % 4 == 1) {

//     }
//     if (step % 4 == 2) {

//     }
//     if (step % 4 == 3) {

//     }
//   }

//   _time.advance();
// }

// _time.advance(_time.beat);
