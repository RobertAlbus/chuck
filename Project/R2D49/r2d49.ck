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

Machine.add("Project/R2D49/time2.ck");
Machine.add("Project/R2D49/knob_scaled.ck");
Machine.add("Project/R2D49/midi_chords.ck");
Machine.add("Project/R2D49/instrument.ck");
Machine.add("Project/R2D49/step_sequencer.ck");
Machine.add("Project/R2D49/ringmod.ck");
Machine.add("Project/R2D49/HH808.ck");
Machine.add("Project/R2D49/OscSynthSingle.ck");
Machine.add("Project/R2D49/kick.ck");
Machine.add("Project/R2D49/patterns.ck");
Machine.add("Project/R2D49/presets.ck");
Machine.add("Project/R2D49/source.ck");
