DependencyManager deps;

deps.foundation.all @=> string foundation[];
deps.feature.all @=> string feature[];

for (0 => int i; i < foundation.size(); i++) {
  Machine.add(foundation[i]);
}
for (0 => int i; i < feature.size(); i++) {
  Machine.add(feature[i]);
}

Machine.add("Project/R2D19/echo.ck");
Machine.add("Project/R2D19/AdsrController.ck");
Machine.add("Project/R2D19/OscSynthMemento.ck");
Machine.add("Project/R2D19/OscSynthBase.ck");
Machine.add("Project/R2D19/OscSynthMementos.ck");
Machine.add("Project/R2D19/OscSynthSingle.ck");
Machine.add("Project/R2D19/OscSynthMulti.ck");
Machine.add("Project/R2D19/source.ck");
