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

    pattern => validateOrder;
    pattern => detectSmallestTimeIncrement;
    pattern => transform @=> pattern;

  }

  fun void update() {
    _time.currentUnit(timeScale) / smallestTimeIncrement => float currentPatternIndex;

    if (currentPatternIndex % 1.0 == 0.0) {
      pattern[currentPatternIndex $ int] @=> float clipPoint[];
      clipPoint.size() == 1 => int isNoOp;
      clipPoint.size() == 2 => int isSinglePoint; // [nextValue, changerate] 
      clipPoint.size() == 3 => int isDoublePoint; // [jumpValue, nextValue, changerate]

      if (isSinglePoint) {
        clipPoint[0] => float target;
        clipPoint[1]::samp => dur changeRate;
        envelope.set(target, changeRate);

      } else if (isDoublePoint) {
        clipPoint[0] => float value;
        clipPoint[1] => float target;
        clipPoint[2]::samp => dur changeRate;
        envelope.set(value);
        envelope.set(target, changeRate);

      } else if (isNoOp) {
        // pass
      }

    }  
  }

  fun float getVal() {
    return envelope.getVal();
  }

  fun float[][] transform(float _pattern[][]) {
    // assumes pattern is in order
    float transformedPattern[0][0];
    for (0 => int i; i < _pattern.size(); i++) {

      i == _pattern.size() -1 => int isLastItem;
      i == 0 => int isFirstItem;


      if (isFirstItem) {
        _pattern[i] @=> float currentClipPoint[];
        if (currentClipPoint.size() != 2){
          <<<"First automation point must only have a time marker and an inital value">>>;
          me.exit();
        }
        currentClipPoint[1] => float targetValue;
        transformedPattern << [targetValue, 0];


      } else if (!isLastItem) {
        _pattern[i] @=> float currentClipPoint[];
        _pattern[i+1] @=> float nextClipPoint[];

        nextClipPoint.size() == 2 => int nextIsSinglePoint; // [timeMarker, currentValue] 
        nextClipPoint.size() == 3 => int nextIsDoublePoint; // [timeMarker, currentValue, jumpValue]

        currentClipPoint[0] => float currentTimeMarker;
        nextClipPoint[0]    => float nextTimeMarker;
        nextTimeMarker - currentTimeMarker => float timeUnitDelta;

        if(nextIsSinglePoint) {
          nextClipPoint[1] => float targetValue;
          timeUnitDelta::timeScale => dur changeRate;
          transformedPattern << [targetValue, changeRate/samp];
        } else if(nextIsDoublePoint) {
          nextClipPoint[1] => float targetValue;
          nextClipPoint[2] => float jumpValue;
          timeUnitDelta::timeScale => dur changeRate;
          transformedPattern << [jumpValue, targetValue, changeRate/samp];
        }

        // no-op spacers
        while(currentTimeMarker < nextTimeMarker) {
          smallestTimeIncrement +=> currentTimeMarker;
          transformedPattern << [0.0];
        }


      } else if (isLastItem) {
        transformedPattern << [0.0];
        transformedPattern << [0.0];
        transformedPattern << [0.0];
        transformedPattern << [0.0];
        transformedPattern << [0.0];
        transformedPattern << [0.0];
      }
    }

    return transformedPattern;
  }

  fun void validateOrder(float _pattern[][]) {
    if (_pattern[0][0] != 0.0) {
      <<<"First automation point must be at time marker 0.0">>>;
      me.exit();
    }
    for (0 => int i; i < _pattern.size(); i++) {
      i == _pattern.size() -1 => int isLastItem;
      if (!isLastItem) {
        if (_pattern[i][0] >= _pattern[i+1][0]) {
          <<<"Entries in the score are not in order">>>;
          me.exit();
        }
      } else {
        if (_pattern.size() > 1 && _pattern[i][0] <= _pattern[i-1][0]) {
          <<<"Entries in the score are not in order">>>;
          me.exit();
        }
      }
    }
  }

  fun void detectSmallestTimeIncrement(float _pattern[][]) {
    for (0 => int i; i < _pattern.size(); i++) {
      _pattern[i][0] % 1 => float timeIncrementRemainder;
      if (timeIncrementRemainder > 0 && timeIncrementRemainder < smallestTimeIncrement) {
        timeIncrementRemainder => smallestTimeIncrement;
      }
    }
  }

  fun void printMatrix(float matrix[][]) {
    for (0 => int i; i < matrix.size(); i++) {
      if (matrix[i].size() == 1) {
        <<<matrix[i][0]>>>;
      } else if (matrix[i].size() == 2) {
        <<<matrix[i][0], matrix[i][1]>>>;
      } else if (matrix[i].size() == 3) { 
        <<<matrix[i][0], matrix[i][1], matrix[i][2]>>>;
      } else if (matrix[i].size() == 4) {
        <<<matrix[i][0], matrix[i][1], matrix[i][2], matrix[i][3]>>>;
      }
    }
  }
}