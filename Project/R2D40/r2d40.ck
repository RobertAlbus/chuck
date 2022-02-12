DependencyManager deps;

deps.foundation.all @=> string foundation[];
deps.feature.all @=> string feature[];

for (0 => int i; i < foundation.size(); i++) {
  Machine.add(foundation[i]);
}
for (0 => int i; i < feature.size(); i++) {
  Machine.add(feature[i]);
}

Machine.add("Project/R2D40/time2.ck");
Machine.add("Project/R2D40/instrument.ck");
Machine.add("Project/R2D40/ringmod.ck");
Machine.add("Project/R2D40/HH808.ck");
Machine.add("Project/R2D40/OscSynthSingle.ck");
Machine.add("Project/R2D40/kick.ck");
Machine.add("Project/R2D40/source.ck");
