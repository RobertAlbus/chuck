public class KnobSet {
  KnobScaled coarse;
  KnobScaled fine;

  0 => float offset;

  fun void set(
    int _midiChannelCoarse,
    float _coarseRange,
    int _midiChannelFine,
    float _fineRange,
    float _offset
  ) {
    coarse.set(_midiChannelCoarse, _coarseRange);
    fine.set(_midiChannelFine, _fineRange);
    _offset => offset;
  }

  fun float getVal(MidiMsg msg) {
    return coarse.getVal(msg) + fine.getVal(msg) + offset; 
  }
}