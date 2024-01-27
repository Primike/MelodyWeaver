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
    
    @Published var isPlaying: Bool = false
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
        sequencer.length = 1
        sequencer.add(noteNumber: 20, position: 0.0, duration: 1)
        loadInstrument("sawPiano1")
    }
    
    var currentIndex = 0

    func loadSong(_ notes: [Int], _ speed: [Int]) {
        songNotes = notes
        noteSpeed = speed
    }
    
    func changeTempo(_ tempo: Double) {
        sequencer.clear()
        sequencer.length = tempo
        sequencer.add(noteNumber: 20, position: 0.0, duration: tempo)
    }
    
    func playMelody() {
        isPlaying = true
        start()
        sequencer.playFromStart()
    }
        
    func playNextNote() {
        let index = currentIndex
        currentIndex += 1
        
        if index >= songNotes.count || index >= noteSpeed.count {
            // Need to send message to viewmodel playSound
            stopMelody()
            return
        }
        
        let note = max(0, songNotes[index])
        sequencer.tempo = Double(noteSpeed[index])
        instrument.play(noteNumber: UInt8(note), velocity: 120, channel: 0)
    }
    
    func stopMelody() {
        currentIndex = 0
        stop()
        isPlaying = false
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
