public class Synth {
  Time _time;
  MidiNotes _notes;

  SawOsc osc => ADSR adsr => Gain output;
  Std.mtof(_notes.D2) => osc.freq;

  0.25::_time.quat => dur A;
  2::_time.quat => dur D;
  0 => float S;
  0.5::_time.quat => dur R;
  adsr.set(A,D,S,R);
}