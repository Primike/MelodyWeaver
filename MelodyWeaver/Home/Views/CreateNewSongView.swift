//
//  CreateNewSongView.swift
//  MelodyWeaver
//
//  Created by Prince Avecillas on 1/25/24.
//

import SwiftUI

struct CreateNewSongView: View {
    var onCreatePressed: () -> Void

    var body: some View {
        NavigationStack {
            VStack {
                
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Create") {
                        onCreatePressed()
                    }
                }
            }
        }
    }
}

#Preview {
    CreateNewSongView(onCreatePressed: {})
}
