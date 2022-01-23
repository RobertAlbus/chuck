DependencyManager deps;

deps.foundation.all @=> string foundation[];
deps.feature.all @=> string feature[];

for (0 => int i; i < foundation.size(); i++) {
  Machine.add(foundation[i]);
}
for (0 => int i; i < feature.size(); i++) {
  Machine.add(feature[i]);
}

Machine.add("Project/R2D21/StringUtils.ck");
Machine.add("Project/R2D21/AdsrController.ck");
Machine.add("Project/R2D21/OscSynthBase.ck");
Machine.add("Project/R2D21/KeyValueStore.ck");
Machine.add("Project/R2D21/OscSynthSingle.ck");
Machine.add("Project/R2D21/OscSynthMulti.ck");
Machine.add("Project/R2D21/source.ck");
