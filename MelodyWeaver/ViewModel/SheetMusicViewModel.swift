//
//  SheetMusicViewModel.swift
//  MelodyWeaver
//
//  Created by Prince Avecillas on 1/21/24.
//

import Foundation
import Tonic

class SheetMusicViewModel: ObservableObject {
    var soundManager = MusicSoundManager()
    @Published var notes: Int
    
    init(notes: Int) {
        self.notes = notes
    }
    
    func buttonPressed(_ isPlaying: Bool) {
        isPlaying ? soundManager.playMelody() : soundManager.stopMelody()
    }
    
    func addNote(_ text: String) {
        notes += 1
    }
//    
//    func playKey(pitch: Pitch, point _: CGPoint) {
//        soundManager.start()
//        soundManager.noteOn(pitch: pitch, point: CGPoint())
//    }
//    
//    func stopKey(pitch: Pitch) {
//        soundManager.noteOff(pitch: pitch)
//    }
}
