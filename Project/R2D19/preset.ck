OscSynthMemento preset;

preset.set("gain", 0.5);
preset.set("cutoff", 200);
preset.set("name", "Ruthless");
preset.set("for", "OscSynthSingle");
<<< preset.getF("cutoff") >>>; // It's a float!

<<< "preset.ck - POC for associative array version of OscSynthMemento" >>>;

<<< preset.serialize2() >>>;
