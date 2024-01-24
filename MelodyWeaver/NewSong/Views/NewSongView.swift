//
//  NewSongView.swift
//  MelodyWeaver
//
//  Created by Prince Avecillas on 1/15/24.
//

import SwiftUI

struct NewSongView: View {
    
    @StateObject var viewModel: SheetMusicViewModel
    @State var selectedTempo: Int = 120 // Default value
    let tempoOptions = [60, 90, 120, 150, 180] // Example tempo values

    var body: some View {
        NavigationView {
            VStack {
                SheetMusicView()
                    .frame(height: UIScreen.main.bounds.height * 0.45)
                KeyboardView()
                    .frame(height: UIScreen.main.bounds.height * 0.45)
            }
            .toolbar(content: {
                HStack {
                    Picker("Tempo", selection: $selectedTempo) {
                        ForEach(tempoOptions, id: \.self) { tempo in
                            Text("\(tempo) BPM").tag(tempo)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())


                    Button(action: {
                        viewModel.playPressed()
                    }, label: {
                        Text(viewModel.isPlaying ? "Stop" : "Play")
                    })
                }
            })
            .environmentObject(viewModel)
        }
    }
}

#Preview {
    NewSongView(viewModel: SheetMusicViewModel())
}

public extension UIScreen {
    static let screenWidth = UIScreen.main.bounds.width
    static let screenHeight = UIScreen.main.bounds.height

}
