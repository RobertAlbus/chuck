public class KeyValueStore {
  StringUtils _string;
  string _properties[0];

  ";" => string _seperator;
  "=" => string _associator;
  5 => int ftoaPrecision;

  fun void configure(string seperator, string associator) {
    seperator => _seperator;
    associator => _associator;
  }

  fun int size() {
    return _properties.size();
  }

  // string keys
  fun void set(string key, string value) {
    _properties << key;
    value => _properties[key];
  }
  fun void set(string key, float value) {
    set(key, Std.ftoa(value, ftoaPrecision));
  }
  fun void set(string key, dur value) {
    value/samp => float samples; 

    if (Math.isnan(samples)) {
      set(key, Std.ftoa(0, ftoaPrecision));
    } else {
      set(key, Std.ftoa(samples, ftoaPrecision));
    }
  }

  // int keys
  fun void set(int key, string value) {
    set(Std.itoa(key), value);
  }
  fun void set(int key, float value) {
    set(Std.itoa(key), value);
  }
  fun void set(int key, dur value) {
    set(Std.itoa(key), value);
  }

  fun string get(int keyIndex) {
    return get(_properties[keyIndex]);
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
    return getF(key)::samp;
  }

  fun string serialize() {
    "" => string preset;
    for (0 => int i; i < _properties.size(); i++) {
      _properties[i] => string key;
      _properties[key] => string value;

      key +=> preset;
      _associator +=> preset;
      value +=> preset;
      if ( i != _properties.size() - 1 ) {
        _seperator +=> preset;
      }
    }
    return preset;
  }

  fun void deserialize(string preset) {
    _string.parseAndAssociate(preset, _seperator, _associator) @=> _properties;
  }
}
