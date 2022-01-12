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
    chords << I << VI << II << V << I << VI << V << VII;

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
}
