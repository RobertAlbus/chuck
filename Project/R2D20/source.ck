// Reference

StringUtils _string;

"gain=0.5000;cutoff=200.0000;name=Ruthless;for=OscSynthSingle" => string preset;

string presetValues[0];
_string.parseAndAssociate(preset, ";", "=") @=> presetValues;

for ( 0 => int i; i < presetValues.size(); i++) {
  presetValues[i] => string key;
  <<<key, presetValues[key]>>>;
}

