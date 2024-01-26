//
//  HomeViewModel.swift
//  MelodyWeaver
//
//  Created by Prince Avecillas on 1/25/24.
//

import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
    
    @AppStorage("songs") private var songsData: Data = Data()
    @Published var songs: [Song] = []

    init() {
        if songsData.isEmpty {
            let defaultSongs = [
                Songs.maryHadALittleLamb,
                Songs.twinkleTwinkleLittleStar,
                Songs.frereJacques,
                Songs.happyBirthday
            ]
            songs = defaultSongs
            songsData = (try? JSONEncoder().encode(defaultSongs)) ?? Data()
        }
        
        if let decodedSongs = try? JSONDecoder().decode([Song].self, from: songsData) {
            self.songs = decodedSongs
        }
    }
    
    func addSong(_ song: Song) {
        if let encodedSongs = try? JSONEncoder().encode(songs) {
            songs.append(song)
            songsData = encodedSongs
        }
    }
}
