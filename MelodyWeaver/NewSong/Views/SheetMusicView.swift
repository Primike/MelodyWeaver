//
//  SheetMusicView.swift
//  MelodyWeaver
//
//  Created by Prince Avecillas on 1/15/24.
//

import SwiftUI

struct SheetMusicView: View {
    @EnvironmentObject var viewModel: SheetMusicViewModel
    var gridItems: [GridItem] = Array(repeating: GridItem(.flexible()), count: 8)

    var body: some View {
        ScrollView {
            LazyVGrid(columns: gridItems, spacing: 10) {
                // Loop through the notes
                ForEach(0..<viewModel.notes.count, id: \.self) { i in
                    VStack {
                        Image(viewModel.getCellImage(i))
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50)
                        
                        Text(viewModel.getCellName(i))
                            .font(.caption)
                        
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    let viewModel = SheetMusicViewModel()
    viewModel.notes = Songs.maryHadALittleLamb.notes
    viewModel.speed = Songs.maryHadALittleLamb.tempos
    return SheetMusicView()
        .environmentObject(viewModel)
}
