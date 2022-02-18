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

Machine.add("Project/R2D46/time2.ck");
Machine.add("Project/R2D46/midi_chords.ck");
Machine.add("Project/R2D46/instrument.ck");
Machine.add("Project/R2D46/step_sequencer.ck");
Machine.add("Project/R2D46/ringmod.ck");
Machine.add("Project/R2D46/HH808.ck");
Machine.add("Project/R2D46/OscSynthSingle.ck");
Machine.add("Project/R2D46/kick.ck");
Machine.add("Project/R2D46/source.ck");
