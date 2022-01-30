public class KnobSet {
  0 => float fine;
  0 => float coarse;

  0 => float fineRange;
  0 => float coarseRange;
  0 => float offset;

  0 => int midiChannelFine;
  0 => int midiChannelCoarse;

  fun void set(
    float _fineRange,
    float _coarseRange,
    float _offset,
    int _midiChannelFine,
    int _midiChannelCoarse
  ) {
    _fineRange => fineRange;
    _coarseRange => coarseRange;
    _offset => offset;
    _midiChannelFine => midiChannelFine;
    _midiChannelCoarse => midiChannelCoarse;
  }

  fun float getVal(MidiMsg msg) {
    if(msg.data2 == midiChannelFine) { // 1A
      msg.data3 / 127.0 * fineRange => fine;
    }
    if(msg.data2 == midiChannelCoarse) { // 1B
      msg.data3 / 127.00 * coarseRange => coarse;
    }

    return coarse + fine + offset;
  }
}