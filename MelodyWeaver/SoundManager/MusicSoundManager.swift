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

class ArpeggiatorConductor: ObservableObject, HasAudioEngine {
    let engine = AudioEngine()
    var instrument = AppleSampler()
    var sequencer: SequencerTrack!
    var midiCallback: CallbackInstrument!
    
    var heldNotes = [Int]()
    var arpUp = false
    var currentNote = 0
    var sequencerNoteLength = 1.0
    
    @Published var tempo : Float = 120.0 {
        didSet{
            sequencer.tempo = BPM(tempo)
        }
    }
    
    @Published var noteLength : Float = 1.0 {
        didSet{
            sequencerNoteLength = Double(noteLength)
            sequencer.clear()
            sequencer.add(noteNumber: 60, position: 0.0, duration: max(0.05, sequencerNoteLength * 0.24))
        }
    }
    
    func noteOn() {
        //add notes to an array
        for i in stride(from: 40, to: 70, by: 5) {
            heldNotes.append(i)
        }
    }
    
    func fireTimer() {
        for i in 0...127 {
            self.instrument.stop(noteNumber: MIDINoteNumber(i), channel: 0)
        }
        if self.heldNotes.count < 1 {
            return
        }
        
        //UP
        if !arpUp {
            let tempArray = heldNotes
            var arrayValue = 0
            if tempArray.max() != currentNote {
                arrayValue = tempArray.sorted().first(where: { $0 > currentNote }) ?? tempArray.min()!
                currentNote = arrayValue
            }else{
                arpUp = true
                arrayValue = tempArray.sorted().last(where: { $0 < currentNote }) ?? tempArray.max()!
                currentNote = arrayValue
            }
            
        }else{
            //DOWN
            let tempArray = heldNotes
            var arrayValue = 0
            if tempArray.min() != currentNote {
                arrayValue = tempArray.sorted().last(where: { $0 < currentNote }) ?? tempArray.max()!
                currentNote = arrayValue
            }else{
                arpUp = false
                arrayValue = tempArray.sorted().first(where: { $0 > currentNote }) ?? tempArray.min()!
                currentNote = arrayValue
            }
        }
        instrument.play(noteNumber: MIDINoteNumber(currentNote), velocity: 120, channel: 0)
    }
    
    func noteOff() {
        let mynote = 40
        
        //remove notes from an array
        for i in heldNotes {
            if i == mynote {
                heldNotes = heldNotes.filter {
                    $0 != mynote
                }
            }
        }
    }
    
    init() {
        
        midiCallback = CallbackInstrument { status, note, vel in
            if status == 144 { //Note On
                self.fireTimer()
            } else if status == 128 { //Note Off
                //all notes off
                for i in 0...127 {
                    self.instrument.stop(noteNumber: MIDINoteNumber(i), channel: 0)
                }
            }
        }
        
        engine.output = PeakLimiter(Mixer(instrument, midiCallback), attackTime: 0.001, decayTime: 0.001, preGain: 0)
        
        do {
            if let fileURL = Bundle.main.url(forResource: "piano", withExtension: "exs") {
                try instrument.loadInstrument(url: fileURL)
            } else {
                Log("Could not find file")
            }
        } catch {
            Log("Could not load instrument")
        }
        
        sequencer = SequencerTrack(targetNode: midiCallback)
        sequencer.length = 0.25
        sequencer.loopEnabled = true
        sequencer.add(noteNumber: 60, position: 0.0, duration: 0.24)
        
        sequencer?.playFromStart()
    }
}

