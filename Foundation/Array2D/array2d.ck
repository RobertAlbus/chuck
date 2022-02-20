public class Array2D {
  Array2DValidate validate;

  fun float[][] transpose(float array[][]) {
    array.size() => int x;
    array[0].size() => int y;

    float arrayTransposed[y][x];

    for (0 => int i; i < x; i ++) {
      for ( 0 => int j; j < y; j++) {
        array[i][j] => arrayTransposed[j][i];
      }
    }

    return arrayTransposed;
  }
}