////////
// CHORDS

public class LibR2D8 {

  fun int[] makeSeventh(int scale[], int start) {
    int chord[4];
    for(0=>int i; i < 4; i++ ){
      (start + (i * 2)) % scale.size() => int noteIndex;
      scale[noteIndex] => chord[i];
    }
    return chord;
  }

  fun int[][] rotateMatrix(int chords [][]) {
    chords.size() => int numChords;
    chords[0].size() => int chordSize;

    int polyphonicMatrix[chordSize][numChords];
    
    for (0 => int i; i < numChords; i++){
      for (0 => int j; j < chordSize; j++){
        chords[i][j] => polyphonicMatrix[j][i];
      }
    }
    return polyphonicMatrix;
  }
}
