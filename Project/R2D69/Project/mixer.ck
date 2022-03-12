public class MixerR2D64 {
  Mixer mixer;
  // panning
  1 => float R;
  -1 => float L;
  0 => float C;

  mixer.createChannel(
    "master", 1.00,
    new MasterProcessing,
    [
      mixer.createChannel(
        "drum bus", 0.10,
        new DrumBusProcessing,
        [
          mixer.createChannel("kick", 1.00, new KickProcessing),
          mixer.createChannel("hat",  1.00, new HatProcessing)
        ]
      ),
      mixer.createChannel(
        "bass bus", 0.10,
        new BassBusProcessing,
        [
          mixer.createChannel("bass arp",  1.00, new BassArpProcessing)
        ]
      ),
      mixer.createChannel(
        "melodic bus", 0.10,
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
}