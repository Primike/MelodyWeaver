//
//  NoteKeyboardView.swift
//  MelodyWeaver
//
//  Created by Prince Avecillas on 1/15/24.
//

import SwiftUI
import Keyboard

struct KeyboardView: View {
    private let pitches = [
        Pitch(0) ... Pitch(16),
        Pitch(12) ... Pitch(28),
        Pitch(24) ... Pitch(40),
        Pitch(36) ... Pitch(52),
        Pitch(48) ... Pitch(64),
        Pitch(60) ... Pitch(76),
        Pitch(72) ... Pitch(88),
        Pitch(84) ... Pitch(100),
        Pitch(96) ... Pitch(112),
        Pitch(108) ... Pitch(124),
    ]

    @EnvironmentObject var viewModel: SheetMusicViewModel
    @State var currentPitch = 5
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    MusicButtonView(action: {}, text: "Tempo")
                    MusicButtonView(action: {
                        changeOctave(-1)
                    }, text: "← Octave")
                    MusicButtonView(action: {
                        changeOctave(1)
                    }, text: "Octave →")

                    MusicButtonView(action: {}, text: "Delete")
                }
                .frame(maxHeight: .infinity)

                
                HStack(spacing: 0) {
                    MusicButtonView(action: {}, text: "Whole")
                    MusicButtonView(action: {}, text: "Half")
                    MusicButtonView(action: {}, text: "Quarter")
                }
                .frame(maxHeight: .infinity)

                HStack(spacing: 0) {
                    MusicButtonView(action: {}, text: "Eight")
                    MusicButtonView(action: {}, text: "Triplet")
                    MusicButtonView(action: {}, text: "Sixteenth")
                }
                .frame(maxHeight: .infinity)

            }
            .padding(.bottom)
            
            Keyboard(layout: .piano(pitchRange: pitches[currentPitch]),
                     noteOn: viewModel.soundManager.noteOn(pitch:point:), noteOff: viewModel.soundManager.noteOff(pitch:))
            .background(.yellow)
        }
        .frame(height: UIScreen.main.bounds.height / 3)
    }
    
    func changeOctave(_ direction: Int) {
        currentPitch = max(0, min(currentPitch + direction, pitches.count - 1))
    }
}

struct MusicButtonView: View {
    @EnvironmentObject var viewModel: SheetMusicViewModel
    var action: () -> Void
    let text: String
    
    var body: some View {
        Button(action: action, label: {
            Text(text)
                .lineLimit(1)
                .fontWeight(.bold)
                .minimumScaleFactor(0.3)
                .foregroundStyle(.black)
                .frame(maxWidth: .infinity)
                .frame(maxHeight: .infinity)
                .border(Color.black, width: 1.5)
                .background(.yellow)
        })
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

//                HStack(spacing: 5) {
//                    MusicButtonView(text: "♮ Standard")
//                    MusicButtonView(text: "♭ Flat")
//                    MusicButtonView(text: "♯ Sharp")
//                }
