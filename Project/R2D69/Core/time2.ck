public class Time2 {
  
  60 => static float _seconds;
  0::samp => static dur playbackOffset;

  static float bpm;
  static dur measure;
  static dur bar;
  static dur beat;
  static dur trip;
  static dur quat;
  
  // setBpm(160);

  fun void setBpm(float bpm_value) {
    bpm_value => bpm;

    _seconds / bpm => float beatLength;
    beatLength::second => beat;
    4::beat => bar;
    4::bar => measure;
    1::beat / 4 => quat;
    1::beat / 3 => trip;
  }

  fun float currentUnit(dur unit) {
    return (now + playbackOffset) / unit;
  }
  fun float currentMeasure() {
    return currentUnit(measure);
  }
  fun float currentBar() {
    return currentUnit(bar);
  }
  fun float currentBeat() {
    return currentUnit(beat);
  }
  fun float currentQuat() {
    return currentUnit(quat);
  }
}
