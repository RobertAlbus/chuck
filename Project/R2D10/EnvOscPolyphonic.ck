public class EnvOscPolyphonic {
  EnvOsc units[];

  fun void setFreqs(float freqs[]) {
    for (0 => int i; i < units.size(); i++) {
      freqs[i] => units[i].freq;
    }
  }
  fun void setNotes(int notes[]) {
    for (0 => int i; i < units.size(); i++) {
      Std.mtof(notes[i]) => units[i].freq;
    }
  }
  
  fun void setFreq(float freq) {
    for (0 => int i; i < units.size(); i++) {
      
    }
  }


  fun void setFreq(float freq) {
    for (0 => int i; i < units.size(); i++) {
      
    }
  }


  fun void setFreq(float freq) {
    for (0 => int i; i < units.size(); i++) {
      
    }
  }



}