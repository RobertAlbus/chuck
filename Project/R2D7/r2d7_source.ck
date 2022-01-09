Time _time;
_time.setBpm(120);

int myArray[0];

fun void print(int iteration) {
  <<< "iteration: ", iteration >>>;
  for (0 => int i; i < myArray.size(); i++) {
    <<< myArray[i] >>>;
  }
}
fun void printSize() {
  <<< "size
  : ", myArray.cap() >>>;
}
print(1);
printSize();

myArray << 1 << 2 << 5 << 6;

print(2);
printSize();

for (0 => int i; i < 2; i++) {
  myArray << 9;
}

print(3);
printSize();

55 => myArray.size;
printSize();
print(4);

// while ( now / _time.bar < 4) {

  // if (_time.isStepStart()){
    // _time.sequenceStep() => int step;

    
  // }

  // _time.advance();
// }


// _time.advance(_time.beat);
