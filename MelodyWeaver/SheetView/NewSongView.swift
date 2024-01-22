//
//  NewSongView.swift
//  MelodyWeaver
//
//  Created by Prince Avecillas on 1/15/24.
//

import SwiftUI

struct NewSongView: View {
    @StateObject var viewModel: SheetMusicViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    SheetMusicView()
                        .frame(height: UIScreen.main.bounds.height * 0.55)
                }
                KeyboardView()
                    .frame(height: UIScreen.main.bounds.height * 0.4)
            }
            .toolbar(content: {
                Button(action: {
                    viewModel.playSound()
                }, label: {
                    Text("Button")
                })
            })
            .environmentObject(viewModel)
        }
    }
}

#Preview {
    NewSongView(viewModel: SheetMusicViewModel(notes: 85))
}

public extension UIScreen {
    static let screenWidth = UIScreen.main.bounds.width
    static let screenHeight = UIScreen.main.bounds.height

}
