public class OscSynthMementos {
  MidiNotes _notes;
  Time _time;

  OscSynthMemento default;
  "sine"    => default.oscType;
  _notes.C5 => default.note;
  0         => default.tuneSemi;
  0         => default.tuneCent;
  20000     => default.filterCutoff;
  0         => default.pitchEnvAmount;
  0         => default.filterEnvAmount;
  0::_time.quat => default.amp_A;
  0::_time.quat => default.amp_D;
  1             => default.amp_S;
  0::_time.quat => default.amp_R;
  0::_time.quat => default.filt_A;
  0::_time.quat => default.filt_D;
  0             => default.filt_S;
  0::_time.quat => default.filt_R;
  0::_time.quat => default.pitch_A;
  0::_time.quat => default.pitch_D;
  0             => default.pitch_S;
  0::_time.quat => default.pitch_R;

}