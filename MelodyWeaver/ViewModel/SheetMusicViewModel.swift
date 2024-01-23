//
//  SheetMusicViewModel.swift
//  MelodyWeaver
//
//  Created by Prince Avecillas on 1/21/24.
//

import Foundation
import Tonic


enum NoteType: Int {
    case whole = 15
    case half = 30
    case quarter = 60
    case triplet = 180
    case eight = 120
    case sixteenth = 240
}

class SheetMusicViewModel: ObservableObject {
    var soundManager = MusicSoundManager()
    var noteLength = NoteType.quarter
    
    @Published var notes = Songs.twinkleTwinkleLittleStar.notes
    var speed = Songs.twinkleTwinkleLittleStar.tempos

    init() {
//        self.notes = notes
    }
    
    func playPressed(_ isPlaying: Bool) {
        soundManager.loadSong(notes, speed)
        isPlaying ? soundManager.playMelody() : soundManager.stopMelody()
    }
    
    func noteOn(pitch: Pitch, point _: CGPoint) {
        soundManager.loadSong([pitch.intValue], [10])
        soundManager.playMelody()
    }

    func noteOff(pitch: Pitch) {
        soundManager.stopMelody()
    }

    func addNote() {
    }
    
    func deleteNode() {
        if notes.count > 0 {
            notes.removeLast()
            speed.removeLast()
        }
    }
    
    func changeTempo(_ tempo: Int) {
        // change the sequencer
    }
    
    func changeNoteType(_ type: NoteType) {
        noteLength = type
    }
}

struct Song {
    var notes: [Int]
    var tempos: [Int]
}

struct Songs {
    static let maryHadALittleLamb = Song(
        notes: [64, 62, 60, 62, 64, 64, 64, 62, 62, 62, 64, 67, 67,
                64, 62, 60, 62, 64, 64, 64, 64, 62, 62, 64, 62, 60],
        tempos: [60, 60, 60, 60, 60, 60, 30, 60, 60, 30, 60, 60, 30,
                 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60]
    )
    
    static let twinkleTwinkleLittleStar = Song(
        notes: [60, 60, 67, 67, 69, 69, 67, 0, 65, 65, 64, 64, 62, 62, 60, 0,
                67, 67, 65, 65, 64, 64, 62, 0, 67, 67, 65, 65, 64, 64, 62, 0,
                60, 60, 67, 67, 69, 69, 67, 0, 65, 65, 64, 64, 62, 62, 60],
        tempos: Array(repeating: 60, count: 46)
    )
}
