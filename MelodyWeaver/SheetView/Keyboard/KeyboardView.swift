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
    @State var currentPitch = 5
    private let pitches = KeyboardRange.startAtC
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 0) {
                // MARK: - Middle Buttons
                
                HStack(spacing: 0) {
                    NoteTypeButtonView(text: "Whole", noteType: .whole)
                    NoteTypeButtonView(text: "Half", noteType: .half)
                    NoteTypeButtonView(text: "Quarter", noteType: .quarter)
                }
                .frame(maxHeight: .infinity)
                // MARK: - Bottom Buttons
                
                HStack(spacing: 0) {
                    NoteTypeButtonView(text: "Eight", noteType: .eight)
                    NoteTypeButtonView(text: "Triplet", noteType: .triplet)
                    NoteTypeButtonView(text: "Sixteenth", noteType: .sixteenth)
                }
                .frame(maxHeight: .infinity)

                // MARK: - Top Buttons
                
                HStack(spacing: 0) {
                    MusicButtonView(action: { viewModel.changeTempo(1) }, text: "Rest")
                    MusicButtonView(action: { changeOctave(-1) }, text: "←")
                    MusicButtonView(action: { changeOctave(1) }, text: "→")
                    MusicButtonView(action: { viewModel.deleteNode() }, text: "Delete")
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

#Preview {
    let viewModel = SheetMusicViewModel()
    return KeyboardView()
        .environmentObject(viewModel)
}

struct KeyboardRange {
    static let startAtC = [
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
}
