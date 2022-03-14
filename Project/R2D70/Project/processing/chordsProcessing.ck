public class ChordsProcessing extends StereoProcessor {

  inL => HPF HpfL => outL;
  inR => HPF HpfR => outR;
  
  300 => HpfL.freq => HpfR.freq;
  0.8 => HpfL.Q => HpfR.Q;

  fun void update() {}
}