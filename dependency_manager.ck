class FoundationModule {
  "Foundation/Controller/adsr_controller.ck" => string controller_adsr;

  "Foundation/String/string_utils.ck" => string string_utils;
  "Foundation/Array/rotate.ck" => string array_rotate;
  "Foundation/Time/time.ck" => string time_module;

  // midi_intervals first
  "Foundation/Midi/midi_intervals.ck" => string midi_intervals;
  "Foundation/Midi/midi_notes.ck"     => string midi_notes;
  "Foundation/Midi/midi_scales.ck"    => string midi_scales;
  
  
  "Foundation/Array2D/array2d_validate.ck"     => string Array2DValidate;
  "Foundation/Array2D/array2d.ck"           => string Array2D;

  "Foundation/Store/key_value_store.ck" => string kv_store; // depends on string_utils.ck

  [
    Array2DValidate,
    Array2D,
    controller_adsr,
    string_utils,
    array_rotate,
    time_module, 
    midi_intervals,
    midi_notes,
    midi_scales,
    kv_store
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