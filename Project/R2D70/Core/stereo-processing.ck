public class StereoProcessor {

  Gain inL;
  Gain inR;
  Gain outL;
  Gain outR;
  
  // call this every sample
  fun void update() {
    process(inL.last(), inR.last());
  }

  fun void process(float L, float R) {
    <<<"Unconfigured StereoProcessor subclass.">>>;
    <<<"Must define process(f,f).">>>;
    me.exit();
  }

  fun StereoProcessor connect(StereoProcessor from) {
    from.outL => inL;
    from.outR => inR;

    return this;
  }

  fun void patchThrough() {
    inL => outL;
    inR => outR;
  }
}
