public class UGenPicker {
    fun UGen pick(string type) {
    type.lower() => type;

    if (type == "sine" || type == "sin") {
      return new SinOsc;
    }
    else if (type == "saw") {
      return new SawOsc;
    }
    else if (type == "square" || type == "sqr") {
      return new SqrOsc;
    }
    else if (type == "triangle" || type == "tri") {
      return new TriOsc;
    }
    else if (type == "noise" || type == "nz") {
      return new Noise;
    } else {
      <<<"Invalid selection UGenPicker.pick(",type,")">>>;
      me.exit();
    }
  }
}