public class StepSequencerPatternManager {
  StepSequencer stsq;
  
  KeyIndexer triggerIndexer;
  float triggerPatterns[][];
  -1 => int lastTriggerIndex;

  KeyIndexer noteIndexer;
  float notePatterns[][];
  -1 => int lastNoteIndex;

  fun void init(
    Instrument instruments[],

    float triggerIndexerKeys[],
    int triggerIndexerInitialValue,
    float _triggerPatterns[][],

    float noteIndexerKeys[],
    int noteIndexerInitialValue,
    float _notePatterns[][]
  ) {
    instruments @=> stsq.instruments;
    triggerIndexer.set(triggerIndexerKeys, triggerIndexerInitialValue);
    _triggerPatterns @=> triggerPatterns;
    
    noteIndexer.set(noteIndexerKeys, noteIndexerInitialValue);
    _notePatterns @=> notePatterns;
  }

  fun void setTriggerPattern(int patternIndex) {
    triggerIndexer.set(patternIndex);
  }
  fun void setNotePattern(int patternIndex) {
    noteIndexer.set(patternIndex);
  }

  fun void update(MidiMsg msg) {
    triggerIndexer.getVal(msg);
    noteIndexer.getVal(msg);
    update();
  }

  fun void update() {
    triggerIndexer.safeValue() => int currentTriggerIndex;
    if (currentTriggerIndex != lastTriggerIndex) {
      triggerPatterns[currentTriggerIndex] @=> stsq.triggerSteps;
      currentTriggerIndex => lastTriggerIndex;
    }

    noteIndexer.safeValue() => int currentNoteIndex;
    if (currentNoteIndex != lastNoteIndex) {
      notePatterns[currentNoteIndex] @=> stsq.noteSteps;
      currentNoteIndex => lastNoteIndex;
    }
  }

  fun void setTriggerPattern(int index){
    triggerIndexer.set(index);
    update();
  }
  fun void setNotePattern(int index){
    noteIndexer.set(index);
    update();
  }

  // how can I get rid of this?
  // add a class member "playbackRate"
  // in update: stsq.play(now/playbackrate) 
  fun void play(int step) {
    stsq.play(step);
  }
}