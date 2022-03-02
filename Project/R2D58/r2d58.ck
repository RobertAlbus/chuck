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
Machine.add("Project/R2D58/Core/time2.ck");
Machine.add("Project/R2D58/Core/key_indexer.ck");
Machine.add("Project/R2D58/Core/knob_scaled.ck");
Machine.add("Project/R2D58/Core/midi_chords.ck");

// FOUNDATION
Machine.add("Project/R2D58/Foundation/instrument.ck");

// INSTRUMENTS
Machine.add("Project/R2D58/Instrument/ringmod.ck");
Machine.add("Project/R2D58/Instrument/HH808.ck");
Machine.add("Project/R2D58/Instrument/OscSynthSingle.ck");
Machine.add("Project/R2D58/Instrument/kick.ck");
Machine.add("Project/R2D58/Instrument/step_sequencer.ck");

// META
Machine.add("Project/R2D58/Meta/StepSequencerPatternManager.ck");

// PROJECT
Machine.add("Project/R2D58/Project/patterns.ck");
Machine.add("Project/R2D58/Project/presets.ck");
Machine.add("Project/R2D58/Project/source.ck");
