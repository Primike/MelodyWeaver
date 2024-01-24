//
//  SheetMusicViewModel.swift
//  MelodyWeaver
//
//  Created by Prince Avecillas on 1/21/24.
//

import Foundation
import Tonic
import Combine

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
    
    private var soundManager: MusicSoundManager = MusicSoundManager()
    private var cancellables = Set<AnyCancellable>()
    @Published var selectedNoteType: NoteType = .quarter
    @Published var isPlaying = false
    @Published var notes: [Int] = []
    var speed: [Int] = []

    init() {
        soundManager.$isPlaying
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isPlaying in
                self?.isPlaying = isPlaying
            }
            .store(in: &cancellables)
    }

    func playPressed() {
        soundManager.loadSong(notes, speed)
        isPlaying ? soundManager.stopMelody() : soundManager.playMelody()
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

    func addRest() {
        notes.append(-1)
        speed.append(selectedNoteType.rawValue)
    }

    func deleteNode() {
        if notes.count > 0 {
            notes.removeLast()
            speed.removeLast()
        }
    }

    func changeTempo(_ tempo: Int) {
        soundManager.changeTempo(tempo)
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
