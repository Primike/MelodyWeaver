//
//  SheetMusicViewModel.swift
//  MelodyWeaver
//
//  Created by Prince Avecillas on 1/21/24.
//

import Foundation

class SheetMusicViewModel: ObservableObject {
    var soundManager = ArpeggiatorConductor()
    @Published var notes: Int
    
    init(notes: Int) {
        self.notes = notes
    }
    
    func addNote(_ text: String) {
        notes += 1
    }
    
    func playSound() {
        soundManager.start()
        soundManager.noteOn()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in
            guard let self = self else { return }
            self.soundManager.stop()
        }
    }
}
