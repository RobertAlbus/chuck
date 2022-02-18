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

Machine.add("Project/R2D48/time2.ck");
Machine.add("Project/R2D48/knob_scaled.ck");
Machine.add("Project/R2D48/midi_chords.ck");
Machine.add("Project/R2D48/instrument.ck");
Machine.add("Project/R2D48/step_sequencer.ck");
Machine.add("Project/R2D48/ringmod.ck");
Machine.add("Project/R2D48/HH808.ck");
Machine.add("Project/R2D48/OscSynthSingle.ck");
Machine.add("Project/R2D48/kick.ck");
Machine.add("Project/R2D48/source.ck");
