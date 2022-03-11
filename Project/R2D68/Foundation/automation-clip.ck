public class AutomationClip {
  Time2 _time;

  AutomationEnvelope envelope;
  float pattern[0][0];

  1 => float smallestTimeIncrement;
  dur timeScale;

  fun void set(AutomationEnvelope _envelope, float _pattern[][], dur _timeScale) {
    _envelope @=> envelope;
    _pattern @=> pattern;
    _timeScale => timeScale;

    for (0 => int i; i < pattern.size(); i++) {
      pattern[i][0] % 1 => float timeIncrementRemainder;
      if (timeIncrementRemainder > 0 && timeIncrementRemainder < smallestTimeIncrement) {
        timeIncrementRemainder => smallestTimeIncrement;
      }
    }
  }

  fun void update() {
    if (_time.currentUnit(timeScale) % smallestTimeIncrement == 0.0) {
      for (0 => int i; i < pattern.size(); i++) {
        pattern[i][0] => float timeUnit;
        pattern[i][1] => float target;
        dur changeRate;

        pattern[i].size() == 3 => int hasChangerate;
        if(hasChangerate){
          pattern[i][2]::samp => changeRate;
        }

        if(timeUnit == _time.currentUnit(timeScale)) {
          if(hasChangerate) {
            envelope.set(target, changeRate);
          } else {
            envelope.set(target);
          }
        }
      }
    } 
  }

  fun float getVal() {
    return envelope.getVal();
  }

}