public class KnobSet {
  KnobScaled carrier;
  KnobScaled modulator;

  0 => float offset;

  fun void set(
    int _midiChannelCoarse,
    float _carrierRange,
    int _midiChannelFine,
    float _modulatorRange,
    float _offset
  ) {
    carrier.set(_midiChannelCoarse, _carrierRange);
    modulator.set(_midiChannelFine, _modulatorRange);
    _offset => offset;
  }

  fun float getVal(MidiMsg msg) {
    return carrier.getVal(msg) + modulator.getVal(msg) + offset; 
  }
}