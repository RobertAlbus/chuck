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

Machine.add("Project/R2D50/time2.ck");
Machine.add("Project/R2D50/knob_scaled.ck");
Machine.add("Project/R2D50/midi_chords.ck");
Machine.add("Project/R2D50/instrument.ck");
Machine.add("Project/R2D50/step_sequencer.ck");
Machine.add("Project/R2D50/ringmod.ck");
Machine.add("Project/R2D50/HH808.ck");
Machine.add("Project/R2D50/OscSynthSingle.ck");
Machine.add("Project/R2D50/kick.ck");
Machine.add("Project/R2D50/patterns.ck");
Machine.add("Project/R2D50/presets.ck");
Machine.add("Project/R2D50/source.ck");
