//
//  MIDITranslation.swift
//  MelodyWeaver
//
//  Created by Prince Avecillas on 1/23/24.
//

import Foundation

class MIDITranslation {
    static let midiNoteToNoteName: [Int: String] = [
        -1: "Rest",
        0: "C-1", 1: "C♯-1", 2: "D-1", 3: "E♭-1", 4: "E-1", 5: "F-1", 6: "F♯-1", 7: "G-1", 8: "A♭-1", 9: "A-1", 10: "B♭-1", 11: "B-1",
        12: "C0", 13: "C♯0", 14: "D0", 15: "E♭0", 16: "E0", 17: "F0", 18: "F♯0", 19: "G0", 20: "A♭0", 21: "A0", 22: "B♭0", 23: "B0",
        24: "C1", 25: "C♯1", 26: "D1", 27: "E♭1", 28: "E1", 29: "F1", 30: "F♯1", 31: "G1", 32: "A♭1", 33: "A1", 34: "B♭1", 35: "B1",
        36: "C2", 37: "C♯2", 38: "D2", 39: "E♭2", 40: "E2", 41: "F2", 42: "F♯2", 43: "G2", 44: "A♭2", 45: "A2", 46: "B♭2", 47: "B2",
        48: "C3", 49: "C♯3", 50: "D3", 51: "E♭3", 52: "E3", 53: "F3", 54: "F♯3", 55: "G3", 56: "A♭3", 57: "A3", 58: "B♭3", 59: "B3",
        60: "C4", 61: "C♯4", 62: "D4", 63: "E♭4", 64: "E4", 65: "F4", 66: "F♯4", 67: "G4", 68: "A♭4", 69: "A4", 70: "B♭4", 71: "B4",
        72: "C5", 73: "C♯5", 74: "D5", 75: "E♭5", 76: "E5", 77: "F5", 78: "F♯5", 79: "G5", 80: "A♭5", 81: "A5", 82: "B♭5", 83: "B5",
        84: "C6", 85: "C♯6", 86: "D6", 87: "E♭6", 88: "E6", 89: "F6", 90: "F♯6", 91: "G6", 92: "A♭6", 93: "A6", 94: "B♭6", 95: "B6",
        96: "C7", 97: "C♯7", 98: "D7", 99: "E♭7", 100: "E7", 101: "F7", 102: "F♯7", 103: "G7", 104: "A♭7", 105: "A7", 106: "B♭7", 107: "B7",
        108: "C8", 109: "C♯8", 110: "D8", 111: "E♭8", 112: "E8", 113: "F8", 114: "F♯8", 115: "G8", 116: "A♭8", 117: "A8", 118: "B♭8", 119: "B8",
        120: "C9", 121: "C♯9", 122: "D9", 123: "E♭9", 124: "E9", 125: "F9", 126: "F♯9", 127: "G9"
    ]
    
    static let midiTempoToNoteImage: [Int: String] = [
        15: "wholenote",
        30: "halfnote",
        60: "quarternote",
        120: "eightnote",
        180: "triplenote",
        240: "sixteenthnote",
    ]
    
    static let midiTempoToRestImage: [Int: String] = [
        15: "wholerest",
        30: "halfrest",
        60: "quarterrest",
        120: "eightrest",
        180: "tripletrest",
        240: "sixteenthrest",
    ]
    
    static func getName(_ pitch: Int) -> String {
        return midiNoteToNoteName[pitch, default: ""]
    }
    
    static func getImage(_ pitch: Int, _ tempo: Int) -> String {
        if pitch == -1 { return midiTempoToRestImage[tempo, default: ""] }
        return midiTempoToNoteImage[tempo, default: ""]
    }
    
    static let tempoToLength: [Int: Double] = [
        30: 2.0,
        40: 1.5,
        50: 1.2,
        60: 1.0,
        70: 0.857,
        80: 0.75,
        90: 0.667,
        100: 0.6,
        110: 0.545,
        120: 0.5,
        130: 0.462,
        140: 0.429,
        150: 0.4,
        160: 0.375,
        170: 0.353,
        180: 0.333,
        190: 0.316,
        200: 0.3,
        220: 0.273,
        240: 0.25,
        260: 0.231,
        280: 0.214,
        300: 0.2
    ]
}
