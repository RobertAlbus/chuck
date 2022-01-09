class FoundationModule {
  "Foundation/Array/rotate.ck" => string array_rotate;
  "Foundation/Time/time.ck" => string time_module;

  // midi_intervals first
  "Foundation/Midi/midi_intervals.ck" => string midi_intervals;
  "Foundation/Midi/midi_notes.ck"     => string midi_notes;

  [
    array_rotate,
    time_module, 
    midi_intervals,
    midi_notes  
  ] @=> string all[];
}

class FeatureModule {
  "Feature/StepSequencer/step_sequencer.ck"       => string step_sequencer;
  "Feature/StepSequencer/step_sequencer_osc.ck"   => string step_sequencer_osc;
  "Feature/StepSequencer/step_sequencer_env.ck"   => string step_sequencer_env;
  "Feature/StepSequencer/step_sequencer_pitch.ck" => string step_sequencer_pitch;
  [
    step_sequencer, 
    step_sequencer_osc,
    step_sequencer_env,
    step_sequencer_pitch
  ] @=> string all[];
}

public class DependencyManager {
  FoundationModule foundation;
  FeatureModule feature;
}