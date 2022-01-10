Time _time;
_time.setBpm(120);

MidiNotes _notes;
MidiScales _scales;

while ( _time.currentBar() < 2) {

  if (_time.isStepStart()){
    _time.sequenceStep() => int step;

  }

  _time.advance();
}

