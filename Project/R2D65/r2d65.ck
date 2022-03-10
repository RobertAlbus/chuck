DependencyManager deps;

deps.foundation.all @=> string foundation[];
deps.feature.all @=> string feature[];

for (0 => int i; i < foundation.size(); i++) {
  Machine.add(foundation[i]);
}

// CONFLICTS with the class StepSequencer defined in this Project folder
// for (0 => int i; i < feature.size(); i++) {
//   Machine.add(feature[i]);
// }

// CORE
Machine.add("Project/R2D65/Core/time2.ck");
Machine.add("Project/R2D65/Core/key-indexer.ck");
Machine.add("Project/R2D65/Core/knob-scaled.ck");
Machine.add("Project/R2D65/Core/midi-chords.ck");
Machine.add("Project/R2D65/Core/automation-envelope.ck");
Machine.add("Project/R2D65/Core/osc-picker.ck");
Machine.add("Project/R2D65/Core/stereo-processing.ck");

// FOUNDATION
Machine.add("Project/R2D65/Foundation/instrument.ck");
Machine.add("Project/R2D65/Foundation/automation-clip.ck");
Machine.add("Project/R2D65/Foundation/lfo-controller.ck");
Machine.add("Project/R2D65/Foundation/stereo-channel.ck");
Machine.add("Project/R2D65/Foundation/mixer.ck");

// INSTRUMENTS
Machine.add("Project/R2D65/Instrument/ringmod.ck");
Machine.add("Project/R2D65/Instrument/HH808.ck");
Machine.add("Project/R2D65/Instrument/OscSynthSingle.ck");
Machine.add("Project/R2D65/Instrument/kick.ck");
Machine.add("Project/R2D65/Instrument/step-sequencer.ck");

// META
Machine.add("Project/R2D65/Meta/step-sequencer-pattern-manager.ck");

// PROJECT
Machine.add("Project/R2D65/Project/processing/bassArpProcessing.ck");
Machine.add("Project/R2D65/Project/processing/bassBusProcessing.ck");
Machine.add("Project/R2D65/Project/processing/chordsProcessing.ck");
Machine.add("Project/R2D65/Project/processing/drumBusProcessing.ck");
Machine.add("Project/R2D65/Project/processing/hatProcessing.ck");
Machine.add("Project/R2D65/Project/processing/kickProcessing.ck");
Machine.add("Project/R2D65/Project/processing/masterProcessing.ck");
Machine.add("Project/R2D65/Project/processing/melodicBusProcessing.ck");
Machine.add("Project/R2D65/Project/processing/verbPlateProcessing.ck");

Machine.add("Project/R2D65/Project/patterns.ck");
Machine.add("Project/R2D65/Project/presets.ck");
Machine.add("Project/R2D65/Project/mixer.ck");
Machine.add("Project/R2D65/Project/source.ck");
