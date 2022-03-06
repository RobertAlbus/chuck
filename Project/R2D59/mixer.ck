public class Mixer {
  string keys[0]; // push all channel keys to this so I can access them for iteration (eg when soloing)
  Gain chanIn[0];
  Gain muteSolo[0]; // need to integrate this to the routing hooker upper and make methods that operate on it
  Gain chanOut[0];
  UGen chanProcessing[0]; // assign the processing entity to this with a matching key??


  fun Gain createChannel(string channelName, float gain) {
    <<<channelName>>>;
    new Gain @=> chanIn[channelName];
    new Gain @=> chanOut[channelName];
    // use gain arg in here
    chanIn[channelName] @=> chanOut[channelName];

    return chanOut[channelName];
  }
  // Will enforce a single Ugen (chubgraph) as the processor
  fun Gain createChannel(string channelName, float gain, UGen processing) {
    Gain channelIn @=> chanIn[channelName];
    Gain channelOut @=> chanOut[channelName];

    channelIn => processing => channelOut;
    gain => channelOut.gain;

    return channelOut;
  }

  fun Gain createChannel(string channelName, float gain, UGen processing, Gain routedChannels[]) {
    Gain channelIn @=> chanIn[channelName];
    Gain channelOut @=> chanOut[channelName];

    channelIn => processing => channelOut;
    for ( 0 => int i; i < routedChannels.size(); i++ ) {
      routedChannels[i] => channelIn;
    }
    gain * (1.0 / routedChannels.size()) => channelOut.gain;

    return channelOut;
  }

  fun Gain send(string channelName, float gain) {
    chanOut[channelName] => Gain g;
    gain => g.gain;
    return g;
  }

  // fun void connectChannels(string from[], string to, float gain) {
  //   Gain g @=> chanIn[to];
  //   for( 0 => int i; i < from.size(); i++ ) {
  //     chanOut[from[i]] @=> scale;
  //   }
  //   (1 / Math.max(1, from.size())) => float inputScaling;
  //   gain * inputScaling => g.gain;
  // }
}
  

//   Mixer mixer;

// mixer.createChannel(
//   "master", 1.00,
//   masterLimiter,
//   [
//     mixer.createChannel(
//       "drum bus", 1.00,
//       drumBusProcessing,
//       [
//         mixer.createChannel("kick",   1.00, kickProcessing),
//         mixer.createChannel("knock",  0.43, knockProcessing),
//         mixer.createChannel("hat",    0.65, hatProcessing),
//         mixer.createChannel("snare",  0.80, snareProcessing),
//         mixer.createChannel("shaker", 0.71, shakerProcessing)
//       ]
//     ),
//     mixer.createChannel(
//       "bass bus", 0.9,
//       bassBusProcessing,
//       [
//         mixer.createChannel("sub",  1.00, subProcessing),
//         mixer.createChannel("acid", 0.80, acidProcessing)
//       ]
//     ),
//     mixer.createChannel(
//       "synth bus", 0.8,
//       synthBusProcessing,
//       [
//         mixer.createChannel("lead",     0.90, leadProcessing),
//         mixer.createChannel("sazzler",  0.77, sazzlerProcessing),
//         mixer.createChannel("whiner",   0.90, whinerProcessing)
//       ]
//     ),
//     mixer.createChannel(
//       "atmos bus", 0.87,
//       atmosBusProcessing,
//       [
//         mixer.createChannel("air",    0.40, airProcessing),
//         mixer.createChannel("riser",  0.40, riserProcessing)
//       ]
//     ),

//     // sends
//     mixer.createChannel(
//       "verb plate", 0.90,
//       verbPlateProcessing
//       [
//         mixer.send("knock",   0.4),
//         mixer.send("snare",   0.4),
//         mixer.send("hat",     0.4),
//         mixer.send("shaker",  0.4),
//         mixer.send("synth bus",  0.4),
//         mixer.send("atmos bus",  0.4)
//       ]
//     ),
//     mixer.createChannel(
//       "verb hall",  0.90,
//       verbHallProcessing
//       [
//         mixer.send("whiner",    0.4),
//         mixer.send("atmos bus", 0.4)
//       ]
//     ),

//     // sidechain
//     // channels that don't not route to audio out?
//     // or they do route to master so they suck samples, but are forced to 0 gain?
//     mixer.createQuietChannel(
//       "kick sidechain input", 0.0,
//       [
//         mixer.send("kick",  1.00),
//         mixer.send("knock", 0.40)
//       ],
//       kickSidechainInputProcessing
//     )
//   ]
// );
