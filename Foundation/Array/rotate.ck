public class ArrayUtils {

  // TODO: Does ChucK have templates/generics? 
  fun Object[] rotateO(Object array[], int start) {
    Object rotatedArray[array.size()];
    for (0 => int i; i < array.size(); i++) {
      (start + array.size()) % array.size() => int currentIndex;
      array[currentIndex] @=> rotatedArray[i];
    }

    return rotatedArray;
  }

  fun float[] rotateF(float array[], int start) {
    float rotatedArray[array.size()];
    for (0 => int i; i < array.size(); i++) {
      (start + array.size()) % array.size() => int currentIndex;
      array[currentIndex] => rotatedArray[i];
    }

    return rotatedArray;
  }

  fun int[] rotateI(int array[], int start) {
    int rotatedArray[array.size()];
    for (0 => int i; i < array.size(); i++) {
      (start + array.size()) % array.size() => int currentIndex;
      array[currentIndex] => rotatedArray[i];
    }

    return rotatedArray;
  }
}