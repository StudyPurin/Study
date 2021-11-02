//
//  Data.swift
//  Study
//
//  Created by cmStudent on 2021/10/12.
//

import SwiftUI
import AudioToolbox

enum TimerStatus {
    case running
    case pause
    case stopped
}

struct Sound: Identifiable {
    let id: SystemSoundID
    let soundName: String
}

struct DataModel: Identifiable {
    let id = UUID()
    let name: String
    var subItems: [DataModel]?
}
