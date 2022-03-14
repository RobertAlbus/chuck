////////
// CHORDS

public class MidiChords {

  fun float[] makeTriad(float scale[], int start) {
    return makeChord(scale, start, 3);
  }
  fun float[] makeSeventh(float scale[], int start) {
    return makeChord(scale, start, 4);
  }
  fun float[] makeNineth(float scale[], int start) {
    return makeChord(scale, start, 5);
  }

  fun float[] makeChord(float scale[], int start, int size) {
    float chord[size];
    for(0=>int i; i < size; i++ ){
      (start + (i * 2)) % scale.size() => int noteIndex;
      scale[noteIndex] => chord[i];
    }
    return chord;
  }

  fun float[][] getSeventhChords(float scale[]) {
    scale.popBack(); // remove the octave so that we can wrap around the scale for the next note appropriately

    // put this in a loop to handle arbitrary sized scales
    float chords[0][0];
    chords
    << [ 0.0 , 0, 0, 0 ]
    << makeSeventh(scale, 0)
    << makeSeventh(scale, 1)
    << makeSeventh(scale, 2)
    << makeSeventh(scale, 3)
    << makeSeventh(scale, 4)
    << makeSeventh(scale, 5)
    << makeSeventh(scale, 6);

    return chords;
  }
}
