public class MidiScales {
  ArrayUtils _array;
  MidiIntervals _i;

  [
    _i.whole,
    _i.whole,
    _i.semi,
    _i.whole,
    _i.whole,
    _i.whole,
    _i.semi
  ] @=> int heptoniaPrima[];

  fun int[] generateMode(int start, int tonic, int scale[]) {
    _array.rotateI(scale, start) @=> scale;
    return createPitchSet(tonic, scale);
  }

  fun int[] createPitchSet(int tonic, int scale[]) {
    tonic => int currentPitch;
    [currentPitch] @=> int pitchSet[];
    for ( 0 => int i; i < scale.size(); i++ ) {
      scale[i] +=> currentPitch;
      pitchSet << currentPitch;
    }

    return pitchSet;
  }

  fun int[] ionian(int tonic) {
    return generateMode(0, tonic, heptoniaPrima) @=> int intervals[];
  }

  fun int[] dorian(int tonic) {
    return generateMode(1, tonic, heptoniaPrima) @=> int intervals[];
  }

  fun int[] phrygian(int tonic) {
    return generateMode(2, tonic, heptoniaPrima) @=> int intervals[];
  }

  fun int[] lydian(int tonic) {
    return generateMode(3, tonic, heptoniaPrima) @=> int intervals[];
  }

  fun int[] mixolydian(int tonic) {
    return generateMode(4, tonic, heptoniaPrima) @=> int intervals[];
  }

  fun int[] aeolian(int tonic) {
    return generateMode(5, tonic, heptoniaPrima) @=> int intervals[];
  }

  fun int[] locrian(int tonic) {
    return generateMode(6, tonic, heptoniaPrima) @=> int intervals[];
  }

}