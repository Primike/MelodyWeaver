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
    @Published var isPlaying: Bool = false
    @Published var currentIndex = 0
    var sound: String = Instruments.piano1.rawValue
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
        loadInstrument()
    }
        
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
        loadInstrument()
        isPlaying = true
        start()
        sequencer.playFromStart()
    }
        
    func keyboardPressed() {
        loadInstrument()
        start()
        sequencer.playFromStart()
    }
    
    func playNextNote() {
        if currentIndex >= songNotes.count || currentIndex >= noteSpeed.count {
            // Need to send message to viewmodel playSound
            stopSound()
            return
        }
        
        let note = max(0, songNotes[currentIndex])
        sequencer.tempo = Double(noteSpeed[currentIndex])
        instrument.play(noteNumber: UInt8(note), velocity: 120, channel: 0)
        currentIndex += 1
    }
    
    func stopSound() {
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
    
    func loadInstrument() {
        do {
            if let fileURL = Bundle.main.url(forResource: "Sounds/Sampler Instruments/\(sound)", withExtension: "exs") {
                try instrument.loadInstrument(url: fileURL)
            } else {
                Log("Could not find file")
            }
        } catch(let error) {
            print(error)
        }
    }
}
