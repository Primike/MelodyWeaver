//
//  KeyboardButtons.swift
//  MelodyWeaver
//
//  Created by Prince Avecillas on 1/23/24.
//

import Foundation
import SwiftUI

struct NoteTypeButtonView: View {
    @EnvironmentObject var viewModel: SheetMusicViewModel
    let text: String
    let noteType: NoteType

    var body: some View {
        Button(action: {
            viewModel.selectedNoteType = noteType
        }, label: {
            Text(text)
                .lineLimit(1)
                .fontWeight(.bold)
                .minimumScaleFactor(0.4)
                .font(.title3)
                .foregroundStyle(viewModel.selectedNoteType == noteType ? .white : .black)
                .frame(maxWidth: .infinity)
                .frame(maxHeight: .infinity)
                .border(viewModel.selectedNoteType == noteType ? Color.blue : Color.white, width: 1)
                .background(viewModel.selectedNoteType == noteType ? Color.blue : Color(uiColor: .secondarySystemBackground))
        })
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
                .font(.title3)
                .foregroundStyle(.black)
                .frame(maxWidth: .infinity)
                .frame(maxHeight: .infinity)
                .border(Color.white, width: 1)
                .background(Color(uiColor: .secondarySystemBackground))
        })
    }
}
