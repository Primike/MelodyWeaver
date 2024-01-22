//
//  SheetMusicView.swift
//  MelodyWeaver
//
//  Created by Prince Avecillas on 1/15/24.
//

import SwiftUI

struct SheetMusicView: View {
    @EnvironmentObject var viewModel: SheetMusicViewModel
    var gridItems: [GridItem] = Array(repeating: GridItem(.flexible()), count: 10)

    var body: some View {
        ScrollView {
            LazyVGrid(columns: gridItems, spacing: 10) {
                // Loop through the notes
                ForEach(0..<viewModel.notes, id: \.self) { index in
                    VStack {
                        Image("sixteenth")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50)
                        
                        Text("C\(index % 8)")
                            .font(.caption)
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    let viewModel = SheetMusicViewModel(notes: 15)
    return SheetMusicView()
        .environmentObject(viewModel)
}
