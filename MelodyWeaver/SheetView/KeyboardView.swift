//
//  NoteKeyboardView.swift
//  MelodyWeaver
//
//  Created by Prince Avecillas on 1/15/24.
//

import SwiftUI
import Keyboard

struct KeyboardView: View {
    @EnvironmentObject var viewModel: SheetMusicViewModel
    
    var body: some View {
        VStack(spacing: 10) {
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    MusicButtonView(text: "Tempo")
                    MusicButtonView(text: "Octave ↑")
                    MusicButtonView(text: "Octave ↓")
                    MusicButtonView(text: "Delete")
                }

//                HStack(spacing: 5) {
//                    MusicButtonView(text: "♮ Standard")
//                    MusicButtonView(text: "♭ Flat")
//                    MusicButtonView(text: "♯ Sharp")
//                }
                
                HStack(spacing: 0) {
                    MusicButtonView(text: "Whole")
                    MusicButtonView(text: "Half")
                    MusicButtonView(text: "Quarter")
                }
                
                HStack(spacing: 0) {
                    MusicButtonView(text: "Eight")
                    MusicButtonView(text: "Triplet")
                    MusicButtonView(text: "Sixteenth")
                }
            }
            
            Keyboard(layout: .piano(pitchRange: Pitch(48) ... Pitch(64)),
                     noteOn: viewModel.soundManager.noteOn(pitch:point:), noteOff: viewModel.soundManager.noteOff(pitch:))
        }
        .background(.blue)
    }
}

struct MusicButtonView: View {
    @EnvironmentObject var viewModel: SheetMusicViewModel
    let text: String
    
    var body: some View {
        Button(action: {
            addNote(text)
        }, label: {
            Text(text)
                .lineLimit(1)
                .minimumScaleFactor(0.3)
                .foregroundStyle(.black)
        })
        .frame(maxWidth: .infinity)
        .background(.white)
    }
    
    private func addNote(_ note: String) {
        viewModel.addNote(note)
    }
}

#Preview {
    let viewModel = SheetMusicViewModel(notes: 15)
    return KeyboardView()
        .environmentObject(viewModel)
}
//
//MusicButtonView(text: "♩ Whole Note")
//MusicButtonView(text: "♭ Flat")
//MusicButtonView(text: "♯ Sharp")
//
