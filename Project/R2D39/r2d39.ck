DependencyManager deps;

deps.foundation.all @=> string foundation[];
deps.feature.all @=> string feature[];

for (0 => int i; i < foundation.size(); i++) {
  Machine.add(foundation[i]);
}
for (0 => int i; i < feature.size(); i++) {
  Machine.add(feature[i]);
}

Machine.add("Project/R2D39/knobScaled.ck");
Machine.add("Project/R2D39/smoothy.ck");
Machine.add("Project/R2D39/highpassy.ck");
Machine.add("Project/R2D39/source.ck");
