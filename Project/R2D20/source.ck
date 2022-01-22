// Reference

"gain=0.5000;cutoff=200.0000;name=Ruthless;for=OscSynthSingle" => string preset;

fun string[] split(string input, string delimiter) {

  string array[0];

  // get the number of delimiters
  int numberOfDelimiters;
  for(0=> int i; i < (input.length() - delimiter.length() + 1); i++) {
    if (input.substring(i, delimiter.length()) == delimiter) {
      numberOfDelimiters++;
    }
  }

  // get substrings
  0 => int currentPosition;
  input.find(delimiter) => int nextDelimiter;
  
  for (0 => int i; i < numberOfDelimiters; i++ ) {
    input.substring(currentPosition, nextDelimiter) => string section;
    array << section;
    // don't walk off the end
    if (section.length() + delimiter.length() < input.length()) {
      input.substring(section.length() + delimiter.length()) => input;
    }

    input.find(delimiter, currentPosition) => nextDelimiter;
  }
  // final substring
  array << input;

  return array;
}

fun string[] parseAndAssociate(string presetString, string delimiter, string associator) {
  string array[0];

  string properties[0];
  split(presetString, delimiter) @=> properties;
  for ( 0 => int i; i < properties.size(); i++ ) {
    string kv[0];
    split(properties[i], associator) @=> kv;

    kv[1] => array[kv[0]];
    array << kv[0];
  }

  return array;
}

// string firstParse[0];
// split(preset, ";") @=> firstParse; 
// for( 0 => int i; i < firstParse.size(); i++) {
//   <<< firstParse[i] >>>;
// }
// string secondParse[0];
// split(firstParse[0], "=") @=> secondParse;
// for( 0 => int i; i < secondParse.size(); i++) {
//   <<< secondParse[i] >>>;
// }
// string secondParse[0]
// splitAndAssociate(firstParse[i], "=") @=>

string presetValues[0];
parseAndAssociate(preset, ";", "=") @=> presetValues;

for ( 0=>int i; i < presetValues.size(); i++) {
  presetValues[i] => string key;
  <<<key, presetValues[key]>>>;
}

