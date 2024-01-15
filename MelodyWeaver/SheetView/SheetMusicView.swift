//
//  SheetMusicView.swift
//  MelodyWeaver
//
//  Created by Prince Avecillas on 1/15/24.
//

import SwiftUI

struct SheetMusicView: View {
    private var gridItems: [GridItem] = Array(repeating: GridItem(.flexible(), spacing: 10), count: 10)

    var body: some View {
        ScrollView {
            LazyVGrid(columns: gridItems, spacing: 10) {
                // Loop through the notes
                ForEach(0..<15, id: \.self) { index in
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
    SheetMusicView()
}
