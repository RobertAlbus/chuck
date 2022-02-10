public class Smoothy extends Chugen {

  SqrOsc osc => Gain out => blackhole;
  float previous;
  0.01 => float smoothingRange;

  fun float tick(float in) {

    out.last() => float current;

    float val;
    current - previous < smoothingRange => int isWithinRange;
    current > previous => int isMovingUp;

    if (isWithinRange) {
      current => val;
    } else {
      if (isMovingUp){
        // <<<"mod up", current, previous>>>;
        previous + smoothingRange => val;
      } else {
        // <<<"mod down", current, previous>>>;
        previous - smoothingRange => val;
      }
    }
    
    val => previous;
    return val;
  }

}