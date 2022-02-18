public class MidiScales {
  ArrayRotate _array;
  MidiIntervals _i;

  [
    _i.whole,
    _i.whole,
    _i.semi,
    _i.whole,
    _i.whole,
    _i.whole,
    _i.semi
  ] @=> float heptoniaPrima[];

  [
    _i.whole,
    _i.semi,
    _i.whole,
    _i.whole,
    _i.whole,
    _i.whole,
    _i.semi
  ] @=> float minorMelodic[];

  [
    _i.whole,
    _i.semi,
    _i.whole,
    _i.whole,
    _i.semi
    _i.whole,
    _i.semi,
  ] @=> float minorHarmonic[];

  fun float[] generateMode(float start, float tonic, float scale[]) {
    _array.rotateI(scale, start) @=> scale;
    return createPitchSet(tonic, scale);
  }

  fun float[] createPitchSet(float tonic, float scale[]) {
    tonic => float currentPitch;
    [currentPitch] @=> float pitchSet[];
    for ( 0 => float i; i < scale.size(); i++ ) {
      scale[i] +=> currentPitch;
      pitchSet << currentPitch;
    }

    return pitchSet;
  }

  fun float[] ionian(float tonic) {
    return generateMode(0, tonic, heptoniaPrima) @=> float floatervals[];
  }

  fun float[] dorian(float tonic) {
    return generateMode(1, tonic, heptoniaPrima) @=> float floatervals[];
  }

  fun float[] phrygian(float tonic) {
    return generateMode(2, tonic, heptoniaPrima) @=> float floatervals[];
  }

  fun float[] lydian(float tonic) {
    return generateMode(3, tonic, heptoniaPrima) @=> float floatervals[];
  }

  fun float[] mixolydian(float tonic) {
    return generateMode(4, tonic, heptoniaPrima) @=> float floatervals[];
  }

  fun float[] aeolian(float tonic) {
    return generateMode(5, tonic, heptoniaPrima) @=> float floatervals[];
  }

  fun float[] locrian(float tonic) {
    return generateMode(6, tonic, heptoniaPrima) @=> float floatervals[];
  }

  fun float[] minorMelodic(float tonic) {
    return createPitchSet(tonic, minorMelodic);
  }

}