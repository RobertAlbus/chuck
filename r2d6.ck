Time time;
time.setBpm(160);

TriOsc osc => dac;
StepSequencer stsq;
[1,0,0,0,1,0,0,0,1,0,0,0,1,0,1,0] @=> stsq.steps;

fun void playOsc() {
  0.5 => osc.gain;
}

fun void stopOsc() {
  0 => osc.gain;
}

while ( now / time.bar < 0.5) {


  stsq.play(time.sequenceStep());

  time.advance();
}

