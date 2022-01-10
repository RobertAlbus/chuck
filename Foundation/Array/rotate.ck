public class ArrayUtils {

  // TODO: Does ChucK have templates/generics? 
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
}