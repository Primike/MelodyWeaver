//
//  DateFormat.swift
//  MelodyWeaver
//
//  Created by Prince Avecillas on 1/26/24.
//

import Foundation

class DateFormat {
    static func getDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter.string(from: date)
    }
}
