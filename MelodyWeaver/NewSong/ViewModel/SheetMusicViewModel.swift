//
//  SheetMusicViewModel.swift
//  MelodyWeaver
//
//  Created by Prince Avecillas on 1/21/24.
//

import Foundation
import Tonic
import Combine

class SheetMusicViewModel: ObservableObject {
    
    private var soundManager: MusicSoundManager = MusicSoundManager()
    private var cancellables = Set<AnyCancellable>()
    @Published var selectedNoteType: NoteType = .quarter
    @Published var isPlaying = false
    @Published var index: Int = 0
    @Published var song: Song

    init(song: Song) {
        self.song = song
        
        // MARK: - Using combine on sound manager variables
        soundManager.$isPlaying
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isPlaying in
                guard let self = self else { return }
                self.isPlaying = isPlaying
            }
            .store(in: &cancellables)
        
        soundManager.$currentIndex
            .receive(on: DispatchQueue.main)
            .sink { [weak self] newIndex in
                guard let self = self else { return }
                self.index = newIndex
            }
            .store(in: &cancellables)
    }

    func changeName(_ name: String) {
        song.name = name
        song.time = Date()
    }

    // MARK: - Loads and plays the current song
    
    func playPressed() {
        soundManager.loadSong(song.notes, song.speed)
        isPlaying ? soundManager.stopSound() : soundManager.playMelody()
    }

    // MARK: - Only handles the short sound played when a key is touched
    
    func noteOn(pitch: Pitch, point _: CGPoint) {
        // add note if a notetype is selected
        addNote(pitch.intValue)
        soundManager.loadSong([pitch.intValue], [10])
        soundManager.keyboardPressed()
    }

    func noteOff(pitch: Pitch) {
        soundManager.stopSound()
    }
    
    // MARK: - Changes note type like quarter/half/eight
    
    func changeNoteType(_ noteType: NoteType) {
        selectedNoteType = (noteType == selectedNoteType ? .none : noteType)
    }
    
    func addNote(_ pitch: Int) {
        if selectedNoteType == .none { return }
        
        // rests are added as -1
        song.speed.append(selectedNoteType.rawValue)
        song.notes.append(pitch)
    }

    func deleteNote() {
        if song.notes.count > 0 {
            song.notes.removeLast()
            song.speed.removeLast()
        }
    }

    func changeTempo(_ tempo: Int) {
        soundManager.changeTempo(MIDITranslation.tempoToLength[tempo, default: 1])
    }
    
    func changeInstrument(_ sound: String) {
        soundManager.sound = sound
        soundManager.loadInstrument()
    }
    
    // MARK: - Functions for list cells
    
    func getCellName(_ i: Int) -> String {
        return MIDITranslation.getName(song.notes[i])
    }
    
    func getCellImage(_ i: Int) -> String {
        return MIDITranslation.getImage(song.notes[i], song.speed[i])
    }
}
