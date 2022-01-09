class FoundationModule {
  "Foundation/Time/time.ck" => string time_module;

  // midi_intervals first
  "Foundation/Midi/midi_intervals.ck" => string midi_intervals;
  "Foundation/Midi/midi_notes.ck" => string midi_notes;

  [
    time_module, 
    midi_intervals,
    midi_notes  
  ] @=> string all[];
}

class FeatureModule {
  "Feature/StepSequencer/step_sequencer.ck" => string step_sequncer;
  "Feature/StepSequencer/step_sequencer_osc.ck" => string step_sequncer_osc;
  [
    step_sequncer, 
    step_sequncer_osc
  ] @=> string all[];
}

public class DependencyManager {
  FoundationModule foundation;
  FeatureModule feature;
}