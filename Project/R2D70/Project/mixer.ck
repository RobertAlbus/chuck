public class MixerR2D64 {
  Mixer mixer;
  // panning
  1 => float R;
  -1 => float L;
  0 => float C;

// SIDECHAIN DOES NOT SEEM TO WORK!
  KickProcessing kickProcessing;
  BassBusProcessing bassBusProcessing;
  kickProcessing.sidechainSource.outL => bassBusProcessing.sidechainReceive.inL;
  kickProcessing.sidechainSource.outR => bassBusProcessing.sidechainReceive.inR;

  mixer.createChannel(
    "master", 1.00,
    new MasterProcessing,
    [
      mixer.createChannel(
        "drum bus", 0.10,
        new DrumBusProcessing,
        [
          mixer.createChannel("kick", 1.00, kickProcessing),
          mixer.createChannel("hat",  0.80, -0.3, new HatProcessing)
        ]
      ),
      mixer.createChannel(
        "bass bus", 0.10,
        bassBusProcessing,
        [
          mixer.createChannel("bass arp",  0.80, new BassArpProcessing)
        ]
      ),
      mixer.createChannel(
        "melodic bus", 0.40,
        new BassBusProcessing,
        [
          mixer.createChannel("chords",  1.00, new ChordsProcessing)
        ]
      ),
      mixer.createChannel(
        "verb plate",  0.00,
        new VerbPlateProcessing,
        [
          mixer.send("bass arp", 0.4),
          mixer.send("hat", 0.4)
        ]
      )
    ]
  );

  mixer.chanOut["master"].outL => dac.left;
  mixer.chanOut["master"].outR => dac.right;

  // mixer.mute(["melodic bus", "hat"]);
}