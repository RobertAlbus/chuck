public class KeyValueStore {
  StringUtils _string;
  string _properties[0];

  fun void set(string key, string value) {
    _properties << key;
    value => _properties[key];
  }

  fun void set(string key, float value) {
    string stringifiedValue;
    value +=> stringifiedValue;
    set(key, stringifiedValue);
  }

  fun void set(string key, dur value) {
    string stringifiedValue;
    value/samp => float samples; 

    if (Math.isnan(samples)) {
      0.0000 +=> stringifiedValue;
    } else {
      samples +=> stringifiedValue;
    }
    set(key, stringifiedValue);
  }

  fun string get(string key) {
    if (_properties[key] != null) {
      return _properties[key];
    }
    return "";
  }
  fun float getF(string key) {
    return get(key).toFloat();
  }
  fun int getI(string key) {
    return get(key).toInt();
  }
  fun dur getD(string key) {
    return get(key).toFloat()::samp;
  }

  fun string serialize() {
    "" => string preset;
    for (0 => int i; i < _properties.size(); i++) {
      _properties[i] => string key;
      _properties[key] => string value;

      key +=> preset;
      "=" +=> preset;
      value +=> preset;
      if ( i != _properties.size() - 1 ) {
        ";" +=> preset;
      }
    }
    return preset;
  }

  fun void deserialize(string preset) {
    _string.parseAndAssociate(preset, ";", "=") @=> _properties;
  }
}
