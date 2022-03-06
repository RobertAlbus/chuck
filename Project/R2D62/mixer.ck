public class Mixer {
  string keys[0];
  Gain chanIn[0];
  Gain muteSolo[0]; // need to integrate this to the routing hooker upper and make methods that operate on it
  Gain chanOut[0];
  Processing chanProcessing[0];

  fun Gain createChannel(string channelName, float channelGain) {
    keys << channelName;

    new Gain @=> chanIn[channelName];
    new Gain @=> chanOut[channelName];
    chanOut[channelName].gain(channelGain);

    chanIn[channelName] => chanOut[channelName];

    return chanOut[channelName];
  }

  // Will enforce a single Ugen (chubgraph) as the processor
  fun Gain createChannel(string channelName, float channelGain, Processing processing) {
    createChannel(channelName, channelGain);
    processing @=> chanProcessing[channelName];

    chanIn[channelName] => processing => chanOut[channelName];

    return chanOut[channelName];
  }

  fun Gain createChannel(string channelName, float channelGain, Processing processing, Gain routedChannels[]) {
    createChannel(channelName, channelGain, processing);
    for ( 0 => int i; i < routedChannels.size(); i++ ) {
      routedChannels[i] => chanIn[channelName];
    }

    return chanOut[channelName];
  }

  fun Gain send(string channelName, float channelGain) {
    chanOut[channelName] => Gain g;
    g.gain(channelGain);
    return g;
  }

  fun void update() {
    for( 0 => int i; i < keys.size(); i++) {
      keys[i] => string channelName;
      chanProcessing[channelName].update();
    }
  }
}
