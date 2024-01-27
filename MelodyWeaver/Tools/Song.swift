//
//  Song.swift
//  MelodyWeaver
//
//  Created by Prince Avecillas on 1/23/24.
//

import Foundation

struct Song: Codable, Identifiable, Equatable, Comparable {
    let id: UUID
    var name: String
    var time: Date
    var notes: [Int]
    var speed: [Int]
    
    var date: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter.string(from: time)
    }
    
    static func == (l: Song, r: Song) -> Bool {
        return l.id == r.id
    }
    
    static func < (l: Song, r: Song) -> Bool {
        return l.time == r.time
    }
}

struct Songs {
    static let maryHadALittleLamb = Song(
        id: UUID(), name: "Mary Had A Little Lamb", time: Date(),
        notes: [64, 62, 60, 62, 64, 64, 64, 62, 62, 62, 64, 67, 67,
                64, 62, 60, 62, 64, 64, 64, 64, 62, 62, 64, 62, 60],
        speed: [60, 60, 60, 60, 60, 60, 30, 60, 60, 30, 60, 60, 30,
                 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60]
    )
    
    static let twinkleTwinkleLittleStar = Song(
        id: UUID(), name: "Twinkle Twinkle Little Star", time: Date(),
        notes: [60, 60, 67, 67, 69, 69, 67, -1, 65, 65, 64, 64, 62, 62, 60, -1,
                67, 67, 65, 65, 64, 64, 62, -1, 67, 67, 65, 65, 64, 64, 62, -1,
                60, 60, 67, 67, 69, 69, 67, -1, 65, 65, 64, 64, 62, 62, 60],
        speed: Array(repeating: 60, count: 47)
    )
    
    static let happyBirthday = Song(
        id: UUID(), name: "Happy Birthday", time: Date(),
        notes: [-1, 60, 60, 62, 60, 65, 64, -1, 60, 60, 62, 60, 67, 65, -1,
                60, 60, 72, 69, 65, 64, 62, -1, 70, 70, 69, 65, 67, 65],
        speed: [30, 60, 60, 60, 60, 60, 60, 30, 60, 60, 60, 60, 60, 60, 30,
                 60, 60, 60, 60, 60, 60, 60, 30, 60, 60, 60, 60, 60, 60]
    )
    
    static let frereJacques = Song(
        id: UUID(), name: "Frere Jacques", time: Date(),
        notes: [60, 62, 64, 60, 60, 62, 64, 60, 64, 65, 67, -1, 64, 65, 67, -1,
                67, 69, 67, 65, 64, 60, 67, 69, 67, 65, 64, 60, 60, 67, 60, -1,
                60, 67, 60, -1],
        speed: [60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 30, 60, 60, 60, 30,
                 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 30,
                 60, 60, 60, 30]
    )
}
