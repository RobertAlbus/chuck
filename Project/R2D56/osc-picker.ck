public class OscPicker {
    fun Osc pick(string type) {
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
    else {
      <<<"Invalid selection UGenPicker.pick(",type,")">>>;
      me.exit();
    }
  }
}