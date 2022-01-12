public class ArrayRotate {
  // TODO this is not a rotation but an axis change 

  // TODO: Does ChucK have templates/generics? 
  // can I cast Object[] to OTherType[]?
  // consider casting to Object and casting back  at the call site so I only have to define the Object implementation
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

  fun int rotatedIndexI(int array[], int index) {
    // not working for some reason
    array.size() => int arraySize;
    // if (index < 0) { 1+=> index;}
    return ((index % arraySize) + arraySize) % arraySize;
  }
}