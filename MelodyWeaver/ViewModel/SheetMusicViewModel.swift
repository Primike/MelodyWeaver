//
//  SheetMusicViewModel.swift
//  MelodyWeaver
//
//  Created by Prince Avecillas on 1/21/24.
//

import Foundation
import Tonic

enum NoteType: Int {
    case none = 0
    case whole = 15
    case half = 30
    case quarter = 60
    case triplet = 180
    case eight = 120
    case sixteenth = 240
}

class SheetMusicViewModel: ObservableObject {
    var soundManager: MusicSoundManager = MusicSoundManager()
    @Published var selectedNoteType: NoteType = .quarter
    @Published var notes: [Int] = Songs.frereJacques.notes
    var speed: [Int] = Songs.frereJacques.tempos

    init() {}
    
    func playPressed(_ isPlaying: Bool) {
        soundManager.loadSong(notes, speed)
        isPlaying ? soundManager.playMelody() : soundManager.stopMelody()
    }
    
    func noteOn(pitch: Pitch, point _: CGPoint) {
        soundManager.loadSong([pitch.intValue], [10])
        if selectedNoteType != .none {
            speed.append(selectedNoteType.rawValue)
            notes.append(pitch.intValue)
        }
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
    
    func changeNoteType(_ noteType: NoteType) {
        selectedNoteType = (noteType == selectedNoteType ? .none : noteType)
    }
    
    func getCellName(_ i: Int) -> String {
        return MIDITranslation.getName(notes[i])
    }
    
    func getCellImage(_ i: Int) -> String {
        return MIDITranslation.getImage(notes[i], speed[i])
    }
    
}
