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
                // MARK: - Top Buttons
                
                HStack(spacing: 0) {
                    MusicButtonView(action: {
                        viewModel.changeTempo(1)
                    }, text: "Tempo")
                    MusicButtonView(action: {
                        changeOctave(-1)
                    }, text: "← Octave")
                    MusicButtonView(action: {
                        changeOctave(1)
                    }, text: "Octave →")
                    MusicButtonView(action: {
                        viewModel.deleteNode()
                    }, text: "Delete")
                }
                .frame(maxHeight: .infinity)
                // MARK: - Middle Buttons
                
                HStack(spacing: 0) {
                    MusicButtonView(action: {
                        viewModel.changeNoteType(.whole)
                    }, text: "Whole")
                    MusicButtonView(action: {
                        viewModel.changeNoteType(.half)
                    }, text: "Half")
                    MusicButtonView(action: {
                        viewModel.changeNoteType(.quarter)
                    }, text: "Quarter")
                }
                .frame(maxHeight: .infinity)
                // MARK: - Bottom Buttons
                
                HStack(spacing: 0) {
                    MusicButtonView(action: {
                        viewModel.changeNoteType(.eight)
                    }, text: "Eight")
                    MusicButtonView(action: {
                        viewModel.changeNoteType(.triplet)
                    }, text: "Triplet")
                    MusicButtonView(action: {
                        viewModel.changeNoteType(.sixteenth)
                    }, text: "Sixteenth")
                }
                .frame(maxHeight: .infinity)

            }
            .padding(.bottom)
            .background(.black)
            
            // MARK: - Keyboard
            
            Keyboard(layout: .piano(pitchRange: pitches[currentPitch]),
                     noteOn: viewModel.noteOn(pitch:point:), noteOff: viewModel.noteOff(pitch:))
            .background(.black)
            .frame(maxHeight: .infinity)
        }
    }
    
    // MARK: - Functions
    
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
                .minimumScaleFactor(0.4)
                .font(.body)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .frame(maxHeight: .infinity)
                .border(Color.black, width: 1.5)
                .background(.gray)
        })
    }
    
    private func addNote(_ note: String) {
        viewModel.addNote()
    }
}

#Preview {
    let viewModel = SheetMusicViewModel()
    return KeyboardView()
        .environmentObject(viewModel)
}
