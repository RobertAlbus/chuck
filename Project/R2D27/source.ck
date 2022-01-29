Time _time;
_time.setBpm(160);

Wacko wacko => dac;

while(true) {

  (now/2::_time.quat) % 6 => float currentStep;

  if( currentStep == 0) {

  }
  if( currentStep == 1) {

  }
  if( currentStep == 2) {

  }
  if( currentStep == 3) {

  }
  if( currentStep == 4) {

  }
  if( currentStep == 5) {

  }

    _time.advance(1::samp);
}