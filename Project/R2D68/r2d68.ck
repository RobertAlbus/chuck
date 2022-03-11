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
Machine.add("Project/R2D68/Core/time2.ck");
Machine.add("Project/R2D68/Core/key-indexer.ck");
Machine.add("Project/R2D68/Core/knob-scaled.ck");
Machine.add("Project/R2D68/Core/midi-chords.ck");
Machine.add("Project/R2D68/Core/automation-envelope.ck");
Machine.add("Project/R2D68/Core/osc-picker.ck");
Machine.add("Project/R2D68/Core/stereo-processing.ck");

// FOUNDATION
Machine.add("Project/R2D68/Foundation/instrument.ck");
Machine.add("Project/R2D68/Foundation/automation-clip.ck");
Machine.add("Project/R2D68/Foundation/lfo-controller.ck");
Machine.add("Project/R2D68/Foundation/stereo-channel.ck");
Machine.add("Project/R2D68/Foundation/mixer.ck");

// INSTRUMENTS
Machine.add("Project/R2D68/Instrument/ringmod.ck");
Machine.add("Project/R2D68/Instrument/HH808.ck");
Machine.add("Project/R2D68/Instrument/OscSynthSingle.ck");
Machine.add("Project/R2D68/Instrument/kick.ck");
Machine.add("Project/R2D68/Instrument/step-sequencer.ck");

// META
Machine.add("Project/R2D68/Meta/step-sequencer-pattern-manager.ck");

// PROJECT
Machine.add("Project/R2D68/Project/processing/bassArpProcessing.ck");
Machine.add("Project/R2D68/Project/processing/bassBusProcessing.ck");
Machine.add("Project/R2D68/Project/processing/chordsProcessing.ck");
Machine.add("Project/R2D68/Project/processing/drumBusProcessing.ck");
Machine.add("Project/R2D68/Project/processing/hatProcessing.ck");
Machine.add("Project/R2D68/Project/processing/kickProcessing.ck");
Machine.add("Project/R2D68/Project/processing/masterProcessing.ck");
Machine.add("Project/R2D68/Project/processing/melodicBusProcessing.ck");
Machine.add("Project/R2D68/Project/processing/verbPlateProcessing.ck");

Machine.add("Project/R2D68/Project/patterns.ck");
Machine.add("Project/R2D68/Project/presets.ck");
Machine.add("Project/R2D68/Project/mixer.ck");
Machine.add("Project/R2D68/Project/source.ck");
