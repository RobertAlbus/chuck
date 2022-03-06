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

Machine.add("Project/R2D59/time2.ck");
Machine.add("Project/R2D59/mixer.ck");
Machine.add("Project/R2D59/processing/masterProcessing.ck");
Machine.add("Project/R2D59/processing/drumBusProcessing.ck");
Machine.add("Project/R2D59/processing/kickProcessing.ck");
Machine.add("Project/R2D59/processing/hatProcessing.ck");
Machine.add("Project/R2D59/processing/bassBusProcessing.ck");
Machine.add("Project/R2D59/processing/subProcessing.ck");
Machine.add("Project/R2D59/processing/acidProcessing.ck");
Machine.add("Project/R2D59/processing/verbPlateProcessing.ck");
Machine.add("Project/R2D59/source.ck");
