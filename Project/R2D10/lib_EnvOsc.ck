public class EnvOsc {
  new ADSR @=> Envelope env;
  new SinOsc @=> Osc osc;
  UGen @ output;

  osc => env => output;

  fun void setMembers(Envelope _env) {
    _env => env;
    connect();
  }

    fun void setMembers(Osc _osc) {
    _osc => osc;
    connect();
  }

  fun void setMembers(Osc _osc, Envelope _env) {
    _env => env;
    _osc => osc;
    connect();
  }

  setNote()

  fun void connect() {
    osc => env;
    env @=> output;
  }

}

EnvOsc mine;
