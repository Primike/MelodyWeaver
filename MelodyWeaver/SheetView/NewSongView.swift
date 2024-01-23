//
//  NewSongView.swift
//  MelodyWeaver
//
//  Created by Prince Avecillas on 1/15/24.
//

import SwiftUI

struct NewSongView: View {
    @StateObject var viewModel: SheetMusicViewModel
    @State var isPlaying = false
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    SheetMusicView()
                        .frame(height: UIScreen.main.bounds.height * 0.5)
                }
                KeyboardView()
                    .frame(height: UIScreen.main.bounds.height * 0.45)
            }
            .toolbar(content: {
                HStack {
                    Button(action: {
                    }, label: {
                        Text("Tempo")
                    })
                    Button(action: {
                        isPlaying = !isPlaying
                        viewModel.playPressed(isPlaying)
                    }, label: {
                        Text(isPlaying ? "Stop" : "Play")
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
