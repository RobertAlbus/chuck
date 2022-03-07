DependencyManager deps;

deps.foundation.all @=> string foundation[];
deps.feature.all @=> string feature[];

for (0 => int i; i < foundation.size(); i++) {
  Machine.add(foundation[i]);
}

// CONFLICTS with the class StepSequencer defined in this Project folder
// for (0 => int i; i < feature.size(); i++) {
//   Machine.add(feature[i]);
// }

// CORE
Machine.add("Project/R2D64/Core/time2.ck");
Machine.add("Project/R2D64/Core/key_indexer.ck");
Machine.add("Project/R2D64/Core/knob_scaled.ck");
Machine.add("Project/R2D64/Core/midi_chords.ck");
Machine.add("Project/R2D64/Core/automation_envelope.ck");
Machine.add("Project/R2D64/Core/osc_picker.ck");

// FOUNDATION
Machine.add("Project/R2D64/Foundation/instrument.ck");
Machine.add("Project/R2D64/Foundation/automation_clip.ck");
Machine.add("Project/R2D64/Foundation/lfo_controller.ck");

// INSTRUMENTS
Machine.add("Project/R2D64/Instrument/ringmod.ck");
Machine.add("Project/R2D64/Instrument/HH808.ck");
Machine.add("Project/R2D64/Instrument/OscSynthSingle.ck");
Machine.add("Project/R2D64/Instrument/kick.ck");
Machine.add("Project/R2D64/Instrument/step_sequencer.ck");

// META
Machine.add("Project/R2D64/Meta/StepSequencerPatternManager.ck");

// PROJECT
Machine.add("Project/R2D64/Project/patterns.ck");
Machine.add("Project/R2D64/Project/presets.ck");
Machine.add("Project/R2D64/Project/source.ck");
