DependencyManager deps;

deps.foundation.all @=> string foundation[];
deps.feature.all @=> string feature[];

for (0 => int i; i < foundation.size(); i++) {
  Machine.add(foundation[i]);
}
for (0 => int i; i < feature.size(); i++) {
  Machine.add(feature[i]);
}

Machine.add("Project/R2D35/knobScaled.ck");
Machine.add("Project/R2D35/knobSet.ck");
Machine.add("Project/R2D35/inverter.ck");
Machine.add("Project/R2D35/plucker.ck");
Machine.add("Project/R2D35/verb.ck");
Machine.add("Project/R2D35/verbNetwork.ck");
Machine.add("Project/R2D35/source.ck");
