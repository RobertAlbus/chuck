/* 
This class should be re-implemented on a per-composition basis

it is not intended for re-use, but rather to organize the composition's
non-library code into seperate files
 */

public class PatternsR2D49 {
  MidiNotes _notes;
  Time2 _time;
  ////
  // PATTERNS

  0 => float X; // keyOff
  1 => float I; // keyOn
  2 => float _; // pass

  // all exist in F melodic minor
  _notes.D2 => float s;
  _notes.F2 => float t;
  _notes.G2 => float u;
  _notes.Gs2 => float v;
  _notes.E3 => float R;
  _notes.D4 => float S;
  _notes.F3 => float T;
  _notes.G3 => float U;
  _notes.Gs3 => float V;

  // KICK
  [
  //[1|_|_|_|2|_|_|_|3|_|_|_|4|_|_|_|5|_|_|_|6|_|_|_|7|_|_|_|8|_|_|_]
    [I,_,_,_,I,_,_,_,I,_,_,_,I,_,_,_,I,_,_,_,I,_,_,_,I,_,_,_,I,_,I,_],
    [I,_,_,I,_,_,I,_,_,I,_,_,I,_,I,_,I,_,_,I,_,_,I,_,_,I,_,_,I,_,I,X],
    [I,_,_,I,_,_,I,_,I,_,_,I,_,_,I,_],
    [X]
  ] @=> float kickTriggerPatterns[][];

  [
    [_notes.F4]
  ] @=> float kickNotePatterns[][];

  // HAT
  [
  //[1|_|_|_|2|_|_|_|3|_|_|_|4|_|_|_|5|_|_|_|6|_|_|_|7|_|_|_|8|_|_|_]
    [X,_,I,X,_,_,I,X,_,_,I,X,_,_,I,_],
    [X,_,I,_,X,_,I,_,X,_,I,_,X,_,I,_],
    [X,_,I,_,_,_,I,_,_,_,I,_,_,_,I,_,_,_,I,_,_,_,I,_,_,_,I,_,_,_,I,_],
    [X]
  ] @=> float hatTriggerPatterns[][];

  [
    [1.0]
  ] @=> float hatNotePatterns[][];

  // BASS
  [
  //[1|_|_|_|2|_|_|_|3|_|_|_|4|_|_|_|5|_|_|_|6|_|_|_|7|_|_|_|8|_|_|_]
    [I,_,_,I,_,_,I,_,_,I,_,_,I,_,_,_,I,_,_,I,_,_,I,_,_,I,_,_,I,_,_,X],
    [I,_,I,_,_,I,_,_,I,_,_,I,_,_,_,I,_,_,I,_,_,I,_,_,I,_,_,I,_,_,X,I],
    [X]
  ] @=> float bassTriggerPatterns[][];

  [
  //[1|_|_|_|2|_|_|_|3|_|_|_|4|_|_|_|5|_|_|_|6|_|_|_|7|_|_|_|8|_|_|_]
    [t,u,v,t,u,v,s,t,u,v,t,u,v,s,s,s],
    [t,u,v,t,u,v,s,t,u,v,t,u,v,s,s,s,t,u,v,t,u,v,s,t,u,v,t,u,v,R,S,S],
    [t,u,v,T,u,v,S,t,u,v,T,u,t,R,S,S]
  ] @=> float bassNotePatterns[][];

  // CHORDS
  [_notes.G4,_notes.As4,_notes.D4,_notes.F5] @=> float Gm7[];
  [_notes.F4,_notes.Gs4,_notes.C4,_notes.Ds4] @=> float Fm7[];
  float chordProgression[0][0];
  chordProgression 
    << Gm7 << Gm7 << Gm7 << Gm7 << Gm7 << Gm7 << Gm7 << Gm7
    << Gm7 << Gm7 << Gm7 << Gm7 << Gm7 << Gm7 << Gm7 << Gm7
    << Gm7 << Gm7 << Gm7 << Gm7 << Gm7 << Gm7 << Gm7 << Gm7
    << Gm7 << Gm7 << Gm7 << Gm7 << Gm7 << Gm7 << Gm7        << Fm7;

  for (0 => int i; i < chordProgression[0].size(); i++) {
    12.0 -=> chordProgression[0][i];
  }

  Array2D _array2d;
  chordProgression => _array2d.transpose @=> chordProgression;

  [
  //[1|_|_|_|2|_|_|_|3|_|_|_|4|_|_|_|5|_|_|_|6|_|_|_|7|_|_|_|8|_|_|_]
    [X,_,_,_,_,_,I,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
    [X]
  ] @=> float chordTriggerPatterns[][];

  _time.measure/samp => float measure;
  [
    [0.0,  100],
    [8.0,  2000,
           4000],
    [12.0, 800],
    [16.0, 2000]
  ] @=> float bassLpfEnvAmountAutomationPattern[][];



}
