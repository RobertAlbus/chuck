public class StepSequencerPatternManager {
  StepSequencer stsq;

  Object chainedStsqPMs[0];
  
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

  fun void update(MidiMsg msg) {
    triggerIndexer.getVal(msg);
    noteIndexer.getVal(msg);
    update();
    if (chainedStsqPMs.size() != 0){
      for(0 => int i; i < chainedStsqPMs.size(); i++) {
        (chainedStsqPMs[i] $StepSequencerPatternManager).update(msg);
      }
    }
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

  fun void setTriggerPattern(int index) {
    triggerIndexer.set(index);
    update();
    if (chainedStsqPMs.size() != 0){
      for(0 => int i; i < chainedStsqPMs.size(); i++) {
        (chainedStsqPMs[i] $StepSequencerPatternManager).setTriggerPattern(index);
      }
    }
  }
  fun void setNotePattern(int index){
    noteIndexer.set(index);
    update();
    if (chainedStsqPMs.size() != 0){
      for(0 => int i; i < chainedStsqPMs.size(); i++) {
        (chainedStsqPMs[i] $StepSequencerPatternManager).setNotePattern(index);
      }
    }
  }

  // how can I get rid of this?
  // add a class member "playbackRate"
  // in update: stsq.play(now/playbackrate) 
  fun void play(int step) {
    stsq.play(step);
    if (chainedStsqPMs.size() != 0){
      for(0 => int i; i < chainedStsqPMs.size(); i++) {
        (chainedStsqPMs[i] $StepSequencerPatternManager).play(step);
      }
    }
  }

  fun void chain(Object stsqPMs[]) {
    // MUST be StepSequencerPatternMannager[] cast to Object []
    stsqPMs @=> chainedStsqPMs;
  }
}