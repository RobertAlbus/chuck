public class ArrayRotate {

  // TODO: Does ChucK have templates/generics? 
  // can I cast Object[] to OTherType[]?
  fun Object[] rotateO(Object array[], int start) {
    Object rotatedArray[0];
    for (0 => int i; i < array.size(); i++) {
      (start + i + array.size()) % array.size() => int rotatedIndex;
      rotatedArray << array[rotatedIndex];
    }

    return rotatedArray;
  }

  fun float[] rotateF(float array[], int start) {
    float rotatedArray[0];
    for (0 => int i; i < array.size(); i++) {
      (start + i + array.size()) % array.size() => int rotatedIndex;
      rotatedArray << array[rotatedIndex];
    }

    return rotatedArray;
  }

  fun int[] rotateI(int array[], int start) {
    int rotatedArray[0];
    for (0 => int i; i < array.size(); i++) {
      (start + i + array.size()) % array.size() => int rotatedIndex;
      rotatedArray << array[rotatedIndex];
    }

    return rotatedArray;
  }

// TODO: test that this works and then update other methods to use it.
// this will be useful for implementing chords when there are not enough notes in a pitchSet to 
  // do I even need this? - could get away with rotating the array for the same thing. 
  // - rotating the array might be memory intensive at scale
  //so this could provide a lower memory solution
  // fun int rotatedIndexI(int array[], int index) {
  //   return (index + array.size()) % array.size();
  // }
}