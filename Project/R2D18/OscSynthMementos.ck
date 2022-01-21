public class OscSynthMementos {
  MidiNotes _notes;
  Time _time;

  OscSynthMemento mementos[0];

  fun OscSynthMemento get(string presetName) {
    return mementos[presetName];
  }

  OscSynthMemento default @=> mementos["default"]; 
  "sine"    => default.oscType;
  _notes.C5 => default.note;
  0         => default.tuneSemi;
  0         => default.tuneCent;
  20000     => default.filterCutoff;
  0         => default.filterEnvAmount;
  0         => default.pitchEnvAmount;
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

  OscSynthMemento pluckBass1 @=> mementos["pluckBass1"]; 
  "saw"     => pluckBass1.oscType;
  _notes.C5 => pluckBass1.note;
  -24       => pluckBass1.tuneSemi;
  0         => pluckBass1.tuneCent;
  200       => pluckBass1.filterCutoff;
  3000      => pluckBass1.filterEnvAmount;
  0         => pluckBass1.pitchEnvAmount;
  0::_time.quat => pluckBass1.amp_A;
  0::_time.quat => pluckBass1.amp_D;
  1             => pluckBass1.amp_S;
  0::_time.quat => pluckBass1.amp_R;
  0::_time.quat => pluckBass1.filt_A;
  1::_time.quat => pluckBass1.filt_D;
  0.3           => pluckBass1.filt_S;
  1::_time.quat => pluckBass1.filt_R;
  0::_time.quat => pluckBass1.pitch_A;
  0::_time.quat => pluckBass1.pitch_D;
  0             => pluckBass1.pitch_S;
  1::_time.quat => pluckBass1.pitch_R;

}