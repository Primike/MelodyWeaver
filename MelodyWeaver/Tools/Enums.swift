//
//  Enums.swift
//  MelodyWeaver
//
//  Created by Prince Avecillas on 1/27/24.
//

import Foundation
import Keyboard

enum SongSort: String {
    case date = "Filter By Date"
    case name = "Filter By Name"
}

enum NoteType: Int {
    case none = 0
    case whole = 15
    case half = 30
    case quarter = 60
    case triplet = 180
    case eight = 120
    case sixteenth = 240
}

enum Instruments: String, CaseIterable {
    case piano1 = "Piano 1"
    case piano2 = "Piano 2"
    case synth1 = "Synth 1"
    case synth2 = "Synth 2"
    case synth3 = "Synth 3"
}

struct KeyboardRange {
    static let startAtC = [
        Pitch(0) ... Pitch(16),
        Pitch(12) ... Pitch(28),
        Pitch(24) ... Pitch(40),
        Pitch(36) ... Pitch(52),
        Pitch(48) ... Pitch(64),
        Pitch(60) ... Pitch(76),
        Pitch(72) ... Pitch(88),
        Pitch(84) ... Pitch(100),
        Pitch(96) ... Pitch(112),
        Pitch(108) ... Pitch(124),
        Pitch(111)...Pitch(127)
    ]
}
