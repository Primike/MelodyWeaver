//
//  NewSongView.swift
//  MelodyWeaver
//
//  Created by Prince Avecillas on 1/15/24.
//

import SwiftUI

struct NewSongView: View {
    
    @StateObject var viewModel: SheetMusicViewModel
    @State var selectedTempo: Int = 60
    let tempoOptions = Array(MIDITranslation.tempoToLength.keys).sorted()

    var body: some View {
        VStack {
            SheetMusicView()
                .frame(height: UIScreen.main.bounds.height * 0.45)
            KeyboardView()
                .frame(height: UIScreen.main.bounds.height * 0.45)
        }
        .onChange(of: selectedTempo) { newTempo in
            viewModel.changeTempo(newTempo)
        }
        .toolbar(content: {
            HStack {
                Text(viewModel.song.name)
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

#Preview {
    NewSongView(viewModel: SheetMusicViewModel(song: Songs.maryHadALittleLamb))
}

public extension UIScreen {
    static let screenWidth = UIScreen.main.bounds.width
    static let screenHeight = UIScreen.main.bounds.height

}
