public class Time2 {
  
  60 => static float _seconds;

  static float bpm;
  static dur measure;
  static dur bar;
  static dur beat;
  static dur trip;
  static dur quat;
  
  setBpm(160);

  fun static void setBpm(float bpm_value) {
    bpm_value => bpm;

    _seconds / bpm => float beatLength;
    beatLength::second => beat;
    4::beat => bar;
    1::beat / 4 => quat;
    1::beat / 3 => trip;
  }
}
