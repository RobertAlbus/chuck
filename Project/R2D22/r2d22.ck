DependencyManager deps;

deps.foundation.all @=> string foundation[];
deps.feature.all @=> string feature[];

for (0 => int i; i < foundation.size(); i++) {
  Machine.add(foundation[i]);
}
for (0 => int i; i < feature.size(); i++) {
  Machine.add(feature[i]);
}

Machine.add("Project/R2D22/StringUtils.ck");
Machine.add("Project/R2D22/AdsrController.ck");
Machine.add("Project/R2D22/OscSynthBase.ck");
Machine.add("Project/R2D22/KeyValueStore.ck");
Machine.add("Project/R2D22/OscSynthSinglePresets.ck");
Machine.add("Project/R2D22/OscSynthSingle.ck");
Machine.add("Project/R2D22/OscSynthMulti.ck");
Machine.add("Project/R2D22/source.ck");
