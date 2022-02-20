public class Array2DValidate {

  fun void dimensions(float arr[][], int x, int y) {
    if ( x != -1 && arr.size() != x ) {
      <<<"Dimensional checks failed">>>;
      <<<"X value was", arr.size(), "instead of", x>>>;
      me.exit();
    }
    for (0 => int i; i < arr.size(); i ++) {
      if ( y != -1 && arr[i].size() != y
      ) {
        <<<"Dimensional checks failed">>>;
        <<<"Y value at index",i ,"was", arr[i].size(), "instead of", y>>>;
        me.exit();
      }
    }
  }

}
