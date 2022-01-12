DependencyManager deps;

deps.foundation.all @=> string foundation[];
deps.feature.all @=> string feature[];

for (0 => int i; i < foundation.size(); i++) {
  Machine.add(foundation[i]);
}
for (0 => int i; i < feature.size(); i++) {
  Machine.add(feature[i]);
}

Machine.add("Project/R2D10/lib_R2D9.1.ck");
Machine.add("Project/R2D10/lib_R2D10.ck");
Machine.add("Project/R2D10/source.ck");
