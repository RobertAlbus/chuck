public fun PolyphonicOsc {
  Osc oscs[];
  Envelope envs[];

  fun void setFreq(float freqs[]) {
    for (0 => int i; i < oscs.size(); i++) {
      freq => oscs[i].freq;
    }
  }

  fun get setNote(int notes[]) {
    for (0 => int i; i < oscs.size(); i++) {
      freq => oscs[i].freq;
    }
  }
}

class EnvOsc {
  Envelope env;
  Osc osc;

  
}
