//
//  MelodyWeaverApp.swift
//  MelodyWeaver
//
//  Created by Prince Avecillas on 1/14/24.
//

import SwiftUI

@main
struct MelodyWeaverApp: App {
    var body: some Scene {
        WindowGroup {
            NewSongView(viewModel: SheetMusicViewModel(notes: 15))
        }
    }
}
