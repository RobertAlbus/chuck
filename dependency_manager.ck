"Foundation/" => string PATH_FOUNDATION;
"Feature/" => string PATH_FEATURE;

class FoundationModule {
  fun void addAll() {
    addTime();
    addMidi();
  }

  fun void addTime() {
    Machine.add(PATH_FOUNDATION + "Time/time.ck");
  }
  fun void addMidi() {
    Machine.add(PATH_FOUNDATION + "Midi/midi_intervals.ck");
    Machine.add(PATH_FOUNDATION + "Midi/midi_notes.ck");
  }
}

class FeatureModule {
  fun void addStepSequencer() {
    Machine.add(PATH_FEATURE + "StepSequencer/step_sequencer.ck");
  }
  fun void addStepSequencerOsc() {
    Machine.add(PATH_FEATURE + "StepSequencer/step_sequencer_osc.ck");
  }
}

public class DependencyManager {
  FoundationModule foundation;
  FeatureModule feature;
  fun void addByPath(string name) {
    Machine.add(name);
  }
}