Time _time;
_time.setBpm(40);

Plucker plucker => Gain pluckerChannel => Gain master => dac;
plucker => VerbNet reverb1 => VerbNet reverb2 => Gain verbChannel => master;


0 => reverb1.dry.gain;
0 => reverb2.dry.gain;
0.5 => reverb1.wet.gain;
0.5 => reverb2.wet.gain;
1 => verbChannel.gain;
1 => master.gain;

while(true) {

  (now/1::_time.beat) => float currentBeat;
  if(currentBeat % 8.0 == 0) {
    plucker.pluck();
  }
  if(currentBeat % 1.0 == 0.75) {
  }

  samp=>now;
}
