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
Machine.add("Project/R2D64/Core/time2.ck");
Machine.add("Project/R2D64/Core/key-indexer.ck");
Machine.add("Project/R2D64/Core/knob-scaled.ck");
Machine.add("Project/R2D64/Core/midi-chords.ck");
Machine.add("Project/R2D64/Core/automation-envelope.ck");
Machine.add("Project/R2D64/Core/osc-picker.ck");
Machine.add("Project/R2D64/Core/stereo-processing.ck");

// FOUNDATION
Machine.add("Project/R2D64/Foundation/instrument.ck");
Machine.add("Project/R2D64/Foundation/automation-clip.ck");
Machine.add("Project/R2D64/Foundation/lfo-controller.ck");
Machine.add("Project/R2D64/Foundation/stereo-channel.ck");
Machine.add("Project/R2D64/Foundation/mixer.ck");

// INSTRUMENTS
Machine.add("Project/R2D64/Instrument/ringmod.ck");
Machine.add("Project/R2D64/Instrument/HH808.ck");
Machine.add("Project/R2D64/Instrument/OscSynthSingle.ck");
Machine.add("Project/R2D64/Instrument/kick.ck");
Machine.add("Project/R2D64/Instrument/step-sequencer.ck");

// META
Machine.add("Project/R2D64/Meta/step-sequencer-pattern-manager.ck");

// PROJECT
Machine.add("Project/R2D64/Project/processing/bassArpProcessing.ck");
Machine.add("Project/R2D64/Project/processing/bassBusProcessing.ck");
Machine.add("Project/R2D64/Project/processing/chordsProcessing.ck");
Machine.add("Project/R2D64/Project/processing/drumBusProcessing.ck");
Machine.add("Project/R2D64/Project/processing/hatProcessing.ck");
Machine.add("Project/R2D64/Project/processing/kickProcessing.ck");
Machine.add("Project/R2D64/Project/processing/masterProcessing.ck");
Machine.add("Project/R2D64/Project/processing/melodicBusProcessing.ck");
Machine.add("Project/R2D64/Project/processing/verbPlateProcessing.ck");

Machine.add("Project/R2D64/Project/patterns.ck");
Machine.add("Project/R2D64/Project/presets.ck");
Machine.add("Project/R2D64/Project/mixer.ck");
Machine.add("Project/R2D64/Project/source.ck");
