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
    @State private var isEditingName = false
    @State private var name = ""
    let tempoOptions = Array(MIDITranslation.tempoToLength.keys).sorted()

    var body: some View {
        VStack {
            SheetMusicView()
                .frame(height: UIScreen.screenHeight * 0.4)
            KeyboardView()
                .frame(height: UIScreen.screenHeight * 0.45)
        }
        .onChange(of: selectedTempo) { newTempo in
            viewModel.changeTempo(newTempo)
        }
        .navigationTitle("Name")
        .toolbarTitleMenu {
            Button {
                isEditingName = true
            } label: {
                Text("Change Name")
            }
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
        .sheet(isPresented: $isEditingName) {
            VStack {
                TextField("Enter new name", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                HStack {
                    Button("Cancel") {
                        isEditingName = false
                    }
                    Button("Done") {
                        changeName(name)
                        isEditingName = false
                    }
                }
                .padding()
            }
            .frame(maxWidth: 300)
            .padding()
            .background(Color.white)
            .cornerRadius(15)
            .shadow(radius: 10)
        }

        .environmentObject(viewModel)
    }
    
    private func changeName(_ name: String) {
        viewModel.changeName(name)
    }
}

#Preview {
    NewSongView(viewModel: SheetMusicViewModel(song: Songs.maryHadALittleLamb))
}
