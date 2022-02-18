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

Machine.add("Project/R2D47/time2.ck");
Machine.add("Project/R2D47/knob_scaled.ck");
Machine.add("Project/R2D47/midi_chords.ck");
Machine.add("Project/R2D47/instrument.ck");
Machine.add("Project/R2D47/step_sequencer.ck");
Machine.add("Project/R2D47/ringmod.ck");
Machine.add("Project/R2D47/HH808.ck");
Machine.add("Project/R2D47/OscSynthSingle.ck");
Machine.add("Project/R2D47/kick.ck");
Machine.add("Project/R2D47/source.ck");
