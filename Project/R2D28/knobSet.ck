public class KnobSet {
  KnobScaled coarse;
  KnobScaled fine;

  0 => float offset;

  fun void set(
    float _fineRange,
    float _coarseRange,
    float _offset,
    int _midiChannelFine,
    int _midiChannelCoarse
  ) {
    coarse.set(_midiChannelCoarse, _coarseRange);
    fine.set(_midiChannelFine, _fineRange);
    _offset => offset;
  }

  fun float getVal(MidiMsg msg) {
    return coarse.getVal(msg) + fine.getVal(msg) + offset; 
  }
}