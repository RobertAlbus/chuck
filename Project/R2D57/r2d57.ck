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

Machine.add("Project/R2D57/time2.ck");
Machine.add("Project/R2D57/osc-picker.ck");
Machine.add("Project/R2D57/automation-envelope.ck");
Machine.add("Project/R2D57/automation-clip.ck");
Machine.add("Project/R2D57/lfo-controller.ck");
Machine.add("Project/R2D57/source.ck");
