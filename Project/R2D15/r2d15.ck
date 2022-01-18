DependencyManager deps;

deps.foundation.all @=> string foundation[];
deps.feature.all @=> string feature[];

for (0 => int i; i < foundation.size(); i++) {
  Machine.add(foundation[i]);
}
for (0 => int i; i < feature.size(); i++) {
  Machine.add(feature[i]);
}

Machine.add("Project/R2D15/echo.ck");
Machine.add("Project/R2D15/AdsrController.ck");
Machine.add("Project/R2D15/SingleOscSynth.ck");
Machine.add("Project/R2D15/source.ck");
