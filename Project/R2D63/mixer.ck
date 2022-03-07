public class Mixer {
  string keys[0];
  StereoChannel chanIn[0];
  StereoChannel chanOut[0];
  StereoProcessor chanProcessing[0];

  fun void solo(string channels[]){
    muteAll();
    for ( 0 => int i; i < channels.size(); i++ ) {
      if (hasChannel(channels[i])) {
        chanIn[channels[i]].unmute();
      }
    }
  }
  fun void solo(string channel) {
    solo([channel]);
  }
  
  fun void mute(string channel) {
    mute([channel]);
  }
  fun void mute(string channels[]) {
    for ( 0 => int i; i < channels.size(); i++ ) {
      chanIn[channels[i]].mute();
    }
  }
  fun void muteAll() {
    keys => mute;
  }

  fun void createChannelNoConnect(string channelName) {
    keys << channelName;

    new StereoChannel @=> chanIn[channelName];
    new StereoChannel @=> chanOut[channelName];
  }

  fun StereoChannel createChannel(string channelName, float channelGain) {
    createChannelNoConnect(channelName);
    channelGain => chanIn[channelName].gain;
    chanOut[channelName].gain(channelGain);

    chanIn[channelName].outL => chanOut[channelName].inL;
    chanIn[channelName].outR => chanOut[channelName].inR;

    return chanOut[channelName];
  }

  fun StereoChannel createChannel(
    string channelName,
    float channelGain,
    StereoProcessor processing
  ) {
    createChannelNoConnect(channelName);
    channelGain => chanIn[channelName].gain;
    processing @=> chanProcessing[channelName];

    chanIn[channelName].outL => processing.inL;
    chanIn[channelName].outR => processing.inR;

    processing.outL => chanOut[channelName].inL;
    processing.outR => chanOut[channelName].inR;

    return chanOut[channelName];
  }
  fun StereoChannel createChannel(
    string channelName,
    float channelGain,
    float channelPan,
    StereoProcessor processing
  ) {
    createChannel(channelName, channelGain, processing);
    chanIn[channelName].pan(channelPan);
    
    return chanOut[channelName];
  }

  fun StereoChannel createChannel(
    string channelName,
    float channelGain,
    StereoProcessor processing,
    StereoChannel routedChannels[]
  ) {
    createChannel(channelName, channelGain, processing);
    channelGain => chanIn[channelName].gain;
    for ( 0 => int i; i < routedChannels.size(); i++ ) {
      routedChannels[i].outL => chanIn[channelName].inL;
      routedChannels[i].outR => chanIn[channelName].inR;
    }

    return chanOut[channelName];
  }
  fun StereoChannel createChannel(
    string channelName,
    float channelGain,
    float channelPan,
    StereoProcessor processing,
    StereoChannel routedChannels[]
  ) {
    createChannel(channelName, channelGain, processing, routedChannels);
    chanIn[channelName].pan(channelPan);

    return chanOut[channelName];
  }

  fun StereoChannel send(string channelName, float channelGain) {
    StereoChannel sendChannel;
    chanOut[channelName].outL => sendChannel.inL;
    chanOut[channelName].outR => sendChannel.inR;
    sendChannel.gain(channelGain);
    return sendChannel;
  }

  fun void update() {
    for( 0 => int i; i < keys.size(); i++) {
      keys[i] => string channelName;
      chanProcessing[channelName].update();
    }
  }

  fun int hasChannel(string channelName) {
    for (0 => int i; i < keys.size(); i++) {
      if (keys[i] == channelName) return 1; 
    }
    <<<"No such channel: ", channelName>>>;
    me.exit();
  }
}
