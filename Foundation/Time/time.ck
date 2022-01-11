public class Time {
  
  60 => static float _seconds;
  float bpm;
  dur measure;
  dur bar;
  dur beat;
  dur quat;
  dur trip;
  
  dur advanceIncrement;
  16 => int patternSteps;

  setBpm(120);

  fun void setBpm(float bpm_value) 
  {
    bpm_value => bpm;

    _seconds / bpm => float beatLength;
    beatLength::second => beat;
    4::beat => bar;
    1::beat / 4 => quat;
    1::beat / 3 => trip;

    1::quat => advanceIncrement;
  }

  fun void advance() {
    1::samp => now;
  }

  fun void advance(dur amount) {
    amount => now;
  }

  fun int masterStep() {
    return (now / quat) $ int;
  }

  fun int sequenceStep() {
    return masterStep() % patternSteps;
  }

  fun int isStepStart() {
    return isStartOfUnit(quat);
  }

  fun int isStartOfUnit(dur duration) {
    return (now / samp) % (duration / samp) == 0.0; 
  }
  fun int currentUnit(dur duration) {
    return (now / duration) $ int;
  }

  fun int currentBar() {
    return currentUnit(bar);
  }
}
