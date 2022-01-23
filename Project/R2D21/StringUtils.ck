public class StringUtils {
  fun string[] split(string input, string delimiter) {
    input => string _input;

    string array[0];

    // get the number of delimiters
    int numberOfDelimiters;
    for(0=> int i; i < (_input.length() - delimiter.length() + 1); i++) {
      if (_input.substring(i, delimiter.length()) == delimiter) {
        numberOfDelimiters++;
      }
    }

    // get substrings
    0 => int currentPosition;
    _input.find(delimiter) => int nextDelimiter;
    
    for (0 => int i; i < numberOfDelimiters; i++ ) {
      _input.substring(currentPosition, nextDelimiter) => string section;
      array << section;
      // don't walk off the end
      if (section.length() + delimiter.length() < _input.length()) {
        _input.substring(section.length() + delimiter.length()) => _input;
      }

      _input.find(delimiter, currentPosition) => nextDelimiter;
    }
    // final substring
    array << _input;

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
}
