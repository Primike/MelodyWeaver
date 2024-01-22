//
//  NoteKeyboardView.swift
//  MelodyWeaver
//
//  Created by Prince Avecillas on 1/15/24.
//

import SwiftUI

struct KeyboardView: View {
    @EnvironmentObject var viewModel: SheetMusicViewModel
    
    var body: some View {
        HStack(spacing: 10) {
            VStack {
                HStack(spacing: 5) {
                    MusicButtonView(text: "Tempo")
                    MusicButtonView(text: "Octave ↑")
                    MusicButtonView(text: "Octave ↓")
                    MusicButtonView(text: "Delete")
                }

                HStack(spacing: 5) {
                    MusicButtonView(text: "♮ Standard")
                    MusicButtonView(text: "♭ Flat")
                    MusicButtonView(text: "♯ Sharp")
                }
                
                HStack(spacing: 5) {
                    MusicButtonView(text: "Whole")
                    MusicButtonView(text: "Half")
                    MusicButtonView(text: "Quarter")
                }
                
                HStack(spacing: 5) {
                    MusicButtonView(text: "Eight")
                    MusicButtonView(text: "Triplet")
                    MusicButtonView(text: "Sixteenth")
                }
                
                HStack(spacing: 5) {
                    MusicButtonView(text: "C4")
                    MusicButtonView(text: "D4")
                    MusicButtonView(text: "E4")
                    MusicButtonView(text: "F4")
                }

                HStack(spacing: 5) {
                    MusicButtonView(text: "G4")
                    MusicButtonView(text: "A4")
                    MusicButtonView(text: "B4")
                    MusicButtonView(text: "REST")
                }
            }
        }
        .padding()
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
            
        })
        .frame(maxWidth: .infinity)
        .background(Color(uiColor: .quaternarySystemFill))
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
