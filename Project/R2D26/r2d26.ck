DependencyManager deps;

deps.foundation.all @=> string foundation[];
deps.feature.all @=> string feature[];

for (0 => int i; i < foundation.size(); i++) {
  Machine.add(foundation[i]);
}
for (0 => int i; i < feature.size(); i++) {
  Machine.add(feature[i]);
}

Machine.add("Project/R2D26/OscSynthBase.ck");
Machine.add("Project/R2D26/OscSynthSinglePresets.ck");
Machine.add("Project/R2D26/OscSynthSingle.ck");
Machine.add("Project/R2D26/OscSynthMulti.ck");
Machine.add("Project/R2D26/clipper.ck");
Machine.add("Project/R2D26/source.ck");
