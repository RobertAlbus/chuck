public class VerbNet extends Chubgraph {
  3 => int quantity;

  inlet => Gain dry => Gain sum => outlet;
  Gain network => Gain wet => sum;
  Verb verbs[quantity];

  for( 0=> int i; i < verbs.size(); i++ ) {
    inlet => verbs[i] => network;
    randomize(verbs[i]);
    Math.random2(0, verbs.size()-1) => int randI1;
    verbs[i] => Gain g1 => verbs[randI1];
    Math.random2(0, verbs.size()-1) => int randI2;
    verbs[i] => Gain g2 => verbs[randI2];
    0.009 => g1.gain;
    0.009 => g2.gain;
  }

  fun void randomize(Verb v) {
    Math.random2f(2,40)::ms => v.d.delay;
    Math.random2f(0.6,0.9) => v.fb.gain;
  }
}