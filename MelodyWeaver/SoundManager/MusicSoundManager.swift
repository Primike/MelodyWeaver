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
    var songNotes = [Int]()
    var noteSpeed = [Int]()

    init() {
        midiCallback = CallbackInstrument { [weak self] status, note, vel in
            guard let self = self else { return }
            self.stopNotes()

            if status == 144 {
                if self.songNotes.count < 1 { return }
                self.playNextNote()
            }
        }
        
        engine.output = PeakLimiter(Mixer(instrument, midiCallback), attackTime: 0.001, decayTime: 0.001, preGain: 0)
        
        sequencer = SequencerTrack(targetNode: midiCallback)
        
        // Length has to be equal to duration for note
        sequencer.length = 0.5
        sequencer.add(noteNumber: 20, position: 0.0, duration: 0.5)
        loadInstrument("sawPiano1")
    }
    
    var currentIndex = 0

    func loadSong(_ notes: [Int], _ speed: [Int]) {
        songNotes = notes
        noteSpeed = speed
    }
    
    func changeTempo(_ tempo: Int) {
        sequencer.clear()
        sequencer.length = 0.5
        sequencer.add(noteNumber: 20, position: 0.0, duration: 0.5)
    }
    
    func playMelody() {
        start()
        sequencer.playFromStart()
    }
        
    func playNextNote() {
        let index = currentIndex
        currentIndex += 1
        
        if index >= songNotes.count {
            // Need to send message to view bool if stop at end
            stopMelody()
            return
        }
        
        sequencer.tempo = Double(noteSpeed[index])
        instrument.play(noteNumber: UInt8(songNotes[index]), velocity: 120, channel: 0)
    }
    
    func stopMelody() {
        currentIndex = 0
        stop()
    }
}


extension MusicSoundManager {

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
