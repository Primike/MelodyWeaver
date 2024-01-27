//
//  HomeViewModel.swift
//  MelodyWeaver
//
//  Created by Prince Avecillas on 1/25/24.
//

import Foundation
import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    
//    @AppStorage("songs") private var songsData: Data = Data()
    // create a funciton to return viewmodels for this like create new song
    @Published var songs: [Song] = []
    private var cancellables = Set<AnyCancellable>()

    init() {
        if songs.isEmpty {
            let defaultSongs = [
                Songs.maryHadALittleLamb,
                Songs.twinkleTwinkleLittleStar,
                Songs.frereJacques,
                Songs.happyBirthday
            ]
            songs = defaultSongs
            updateSongsData()
        }
        
//        if let decodedSongs = try? JSONDecoder().decode([Song].self, from: songsData) {
//            self.songs = decodedSongs
//        }
    }
    
    func createNewSong() -> SheetMusicViewModel {
        let date = Date()
        let name = "\(DateFormat.getDate(date)) \(songs.count)"
        let newSong = Song(id: UUID(), name: name, time: date, notes: [], speed: [])
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            songs.append(newSong)
        }
        updateSongsData()
        
        return createViewModel(newSong)
    }
    
    func createViewModel(_ song: Song) -> SheetMusicViewModel {
        let viewModel = SheetMusicViewModel(song: song)
        
        viewModel.$song
            .receive(on: DispatchQueue.main)
            .sink { [weak self] song in
                guard let self = self else { return }
                if let index = self.songs.firstIndex(where: { $0.id == song.id }) {
                    self.songs[index] = song
                }
            }
            .store(in: &cancellables)
        
        return viewModel
    }
    
    func addSong(_ song: Song) {
        if let index = songs.firstIndex(where: { $0.id == song.id }) {
            songs[index] = song
        } else {
            songs.append(song)
        }
        
        updateSongsData()
    }
    
    func deleteSong(_ indexSet: IndexSet) {
        songs.remove(atOffsets: indexSet)
        updateSongsData()
    }
    
    func updateSongsData() {
//        songsData = (try? JSONEncoder().encode(songs)) ?? Data()
    }
    
    func moveSongOrder(indices: IndexSet, newOffset: Int) {
        songs.move(fromOffsets: indices, toOffset: newOffset)
    }
}
