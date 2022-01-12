////////
// CHORDS

public class LibR2D9 {

  fun int[] makeSeventh(int scale[], int start) {
    int chord[4];
    for(0=>int i; i < 4; i++ ){
      (start + (i * 2)) % scale.size() => int noteIndex;
      scale[noteIndex] => chord[i];
    }
    return chord;
  }

  fun int[][] rotateMatrix(int chords [][]) {
    // actually it's an axis change, not a rotation
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

  fun int[][] getChords(int scale[]) {
    scale.popBack(); // remove the octave so that we can wrap around the scale for the next note appropriately

    [ 0, 0, 0, 0 ]        @=> int O[];
    makeSeventh(scale, 0) @=> int I[];
    makeSeventh(scale, 1) @=> int II[];
    makeSeventh(scale, 2) @=> int III[];
    makeSeventh(scale, 3) @=> int IV[];
    makeSeventh(scale, 4) @=> int V[];
    makeSeventh(scale, 5) @=> int VI[];
    makeSeventh(scale, 6) @=> int VII[];

    int chords[0][0];
    // chords << I << VI << II << V << I << VI << V << VII;
    chords << I << IV << IV << V;
    // <<< "HEEEECK">>>;
    // <<< "HEEEECK">>>;
    // <<< "HEEEECK">>>;
    // <<< "HEEEECK">>>;
    // <<< scale[0],scale[1], scale[2], scale[3],scale[4], scale[5], scale[6] >>>;
    // <<< VII[0], VII[1], VII[2], VII[3] >>>;

    int groovyChords[0][0];
    for (0 => int i; i < chords.size(); i++){
      groovyChords << chords[i];
      if (i % 2 == 0) {
        groovyChords << chords[i] << chords[i] << O;
      } else {
        groovyChords << chords[i] << O << O;

      }
    }
    groovyChords @=> chords;
    rotateMatrix(chords) @=> chords;

    return chords;
  }

  fun void setSteps(StepSequencerPitch stsqs_p[], StepSequencerEnv stsqs_e[], int chords[][]) {
    for (0 => int i; i < chords.size(); i++){
      chords[i] @=> stsqs_p[i].steps;
      chords[i] @=> stsqs_e[i].steps;
    }
  }

  fun void print2dArray(int array[][]) {
    for (0=> int i; i < array.size(); i++) {
      // <<< array[i].size() >>>;
      <<< array[i][0], array[i][1], array[i][2], array[i][3], array[i][4], array[i][5], array[i][6] >>>;
    }
  }
}
