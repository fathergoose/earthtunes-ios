//
//  Player.swift
//  EarthTunes
//
//  Created by Al Ilseman on 11/29/19.
//  Copyright © 2019 Listening-To-The-Solid-Earth. All rights reserved.
//

import SwiftUI
import Foundation
import Combine

class Player: ObservableObject {
    @Published var isPlaying = false

    func pauseOrPlay() {
        // Code that toggles the audio on and off
    }
}
