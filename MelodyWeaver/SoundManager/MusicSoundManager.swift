//
//  MusicSoundManager.swift
//  MelodyWeaver
//
//  Created by Prince Avecillas on 1/21/24.
//

import Foundation
import AVFoundation
import AudioKit
import AudioKitEX
import Tonic

class MusicSoundManager: ObservableObject, HasAudioEngine {
    let engine = AudioEngine()
    var instrument = AppleSampler()
    var sequencer: SequencerTrack!
    var midiCallback: CallbackInstrument!
    var notes = [Int]()
    var speed = [Int]()

    init() {
        midiCallback = CallbackInstrument { [weak self] status, note, vel in
            guard let self = self else { return }
            self.stopNotes()

            if status == 144 {
                if self.notes.count < 1 { return }
                self.playNextNote()
            }
        }
        
        engine.output = PeakLimiter(Mixer(instrument, midiCallback), attackTime: 0.001, decayTime: 0.001, preGain: 0)
        
        sequencer = SequencerTrack(targetNode: midiCallback)
        sequencer.length = 0.25
        sequencer.add(noteNumber: 20, position: 0.0, duration: 0.24)

        loadInstrument("sawPiano1")
    }
    
    var currentIndex = 0
    var currentSpeed = 0

    func playMelody() {
        start()

        notes = [64, 62, 60, 62, 64, 64, 64, 62, 62, 62, 64, 67, 67, 64, 62, 60, 62, 64, 64, 64, 64, 62, 62, 64, 62, 60]

        speed = [60, 60, 60, 60, 60, 60, 30, 60, 60, 30, 60, 60, 30, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60]
        sequencer.playFromStart()
    }
    
    func stopMelody() {
        currentIndex = 0
        currentSpeed = 0
        stop()
    }
    
    func playNextNote() {
        let index = currentIndex
        currentIndex += 1
        
        if index >= notes.count {
            // Need to send message to view bool if stop at end
            stopMelody()
            return
        }
        
        sequencer.tempo = Double(speed[index])
        instrument.play(noteNumber: UInt8(notes[index]), velocity: 120, channel: 0)
    }
}


extension MusicSoundManager {
    func noteOn(pitch: Pitch, point _: CGPoint) {
        notes = [pitch.intValue]
        speed = [10]
        start()
        sequencer.playFromStart()
    }

    func noteOff(pitch: Pitch) {
        stopMelody()
    }

    private func stopNotes() {
        for i in 0...127 {
            self.instrument.stop(noteNumber: UInt8(i), channel: 0)
        }
    }
    
    private func loadInstrument(_ name: String) {
        do {
            if let fileURL = Bundle.main.url(forResource: name, withExtension: "exs") {
                try instrument.loadInstrument(url: fileURL)
            } else {
                Log("Could not find file")
            }
        } catch {
            Log("Could not load instrument")
        }
    }
}
