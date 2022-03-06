public class Mixer {
  string keys[0];
  Gain chanIn[0];
  Gain muteSolo[0]; // need to integrate this to the routing hooker upper and make methods that operate on it
  Gain chanOut[0];
  Processing chanProcessing[0];

  fun Gain createChannel(string channelName, float gain) {
    <<<channelName>>>;
    keys << channelName;

    new Gain @=> chanIn[channelName];
    new Gain @=> chanOut[channelName];
    gain => chanOut[channelName].gain;

    chanIn[channelName] @=> chanOut[channelName];

    return chanOut[channelName];
  }

  // Will enforce a single Ugen (chubgraph) as the processor
  fun Gain createChannel(string channelName, float gain, Processing processing) {
    createChannel(channelName, gain);
    processing @=> chanProcessing[channelName];

    chanIn[channelName] => processing => chanOut[channelName];

    return chanOut[channelName];
  }

  fun Gain createChannel(string channelName, float gain, Processing processing, Gain routedChannels[]) {
    createChannel(channelName, gain, processing);
    for ( 0 => int i; i < routedChannels.size(); i++ ) {
      routedChannels[i] => chanIn[channelName];
    }
    gain * (1.0 / routedChannels.size()) => chanOut[channelName].gain;

    return chanOut[channelName];
  }

  fun Gain send(string channelName, float gain) {
    chanOut[channelName] => Gain g;
    gain => g.gain;
    return g;
  }

  fun void update() {
    for( 0 => int i; i < keys.size(); i++) {
      keys[i] => string channelName;
      chanProcessing[channelName].update();
    }
  }
}
