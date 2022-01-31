DependencyManager deps;

deps.foundation.all @=> string foundation[];
deps.feature.all @=> string feature[];

for (0 => int i; i < foundation.size(); i++) {
  Machine.add(foundation[i]);
}
for (0 => int i; i < feature.size(); i++) {
  Machine.add(feature[i]);
}

Machine.add("Project/R2D29/knobScaled.ck");
Machine.add("Project/R2D29/knobSet.ck");
Machine.add("Project/R2D29/wacky.ck");
Machine.add("Project/R2D29/source.ck");
