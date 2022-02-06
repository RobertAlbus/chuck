public class Verb extends Chubgraph {

  inlet => Gain dryTap => Gain fbAdder => Delay d => Gain fbTap => Gain wet => Gain mixer => outlet;

  dryTap => Gain dryGain => mixer;
  fbTap => Gain fb => fbAdder;

  0 => dryGain.gain;
  0.96 => fb.gain;

  7::ms => d.delay;

  fun dur delay(dur duration) {
    duration => d.delay;
    return delay();
  }
  fun dur delay() {
    return d.delay();
  }
}