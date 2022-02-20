// 
/* 
This class should be re-implemented on a per-composition basis

it is not intended for re-use, but rather to organize the composition's
non-library code into seperate files
 */

public class PresetsR2D49 {
  Time2 _time;

  // PLUCK PATCH
  fun void pluck(OscSynthSingle oscSynth){
    "saw" => oscSynth.oscType;
    100 => oscSynth.lpfCutoff;
    1000 => oscSynth.adsrLpfCutoffAmount;
    (0::_time.quat, 1::_time.quat, 0.2, 0::samp) => oscSynth.adsrLpfCutoff.set;
    3.1 => oscSynth.lpf.Q;
  }

  // PAD PATCH
  fun void pad(OscSynthSingle oscSynth){
    "saw" => oscSynth.oscType;
    500 => oscSynth.lpfCutoff;
    500 => oscSynth.adsrLpfCutoffAmount;
    (2::_time.quat, 12::_time.beat, 0, 0::_time.beat) => oscSynth.adsrLpfCutoff.set;
    (0::_time.quat, 12::_time.beat, 0, 0::_time.beat) => oscSynth.adsrAmp.set;
    2.1 => oscSynth.lpf.Q;
  }

  fun void hats(HH808 hats) {
    Std.srand(4896);
    hats.randomize();
  }
}