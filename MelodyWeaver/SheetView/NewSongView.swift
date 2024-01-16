//
//  NewSongView.swift
//  MelodyWeaver
//
//  Created by Prince Avecillas on 1/15/24.
//

import SwiftUI

struct NewSongView: View {
    var body: some View {
        VStack {
            SheetMusicView()
                .frame(height: UIScreen.screenHeight * 0.45)
            NoteKeyboardView()
                .frame(height: UIScreen.screenHeight * 0.45)
        }
    }
}

#Preview {
    NewSongView()
}

public extension UIScreen {
    static let screenWidth = UIScreen.main.bounds.width
    static let screenHeight = UIScreen.main.bounds.height

}
