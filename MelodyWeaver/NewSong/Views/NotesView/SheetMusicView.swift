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
                ForEach(0..<viewModel.song.notes.count, id: \.self) { i in
                    VStack {
                        Image(viewModel.getCellImage(i))
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 55, height: 55)
                        
                        Text(viewModel.getCellName(i))
                            .font(.callout)
                            .minimumScaleFactor(0.4)
                    }
                    .scaleEffect(isHighlighted(i) ? 1.2 : 1.0)
                    .shadow(color: isHighlighted(i) ? Color.blue.opacity(0.7) : Color.clear, radius: 10)
                }
            }
            .padding()
        }
    }
    
    func isHighlighted(_ i: Int) -> Bool {
        return (viewModel.isPlaying && viewModel.index == i + 1)
    }
}

#Preview {
    let viewModel = SheetMusicViewModel(song: Songs.maryHadALittleLamb)
    return SheetMusicView()
        .environmentObject(viewModel)
}
