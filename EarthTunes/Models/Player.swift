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
import AVFoundation


class Player: ObservableObject {
    var source: URL
    var sound: AVAudioPlayer?
    var timer: Timer!
    
    @Published var playedTime = "00:00"
    @Published var isPlaying = false
    
    init(source_url: URL) {
        source = source_url
        do {
            sound = try AVAudioPlayer(contentsOf: source)
        } catch {
            print("couldn't load file")
        }
    }

    @objc func updateTime() {
        let currentTime = Int(self.sound!.currentTime)
        let minutes = currentTime/60
        let seconds = currentTime - minutes * 60
            
        self.playedTime = String(format: "%02d:%02d", minutes,seconds) as String
    }
    
    func durationString() -> String? {
        return String(
            format: "%02d:%02d",
            ((Int)((sound?.duration)!)) / 60,
            ((Int)((sound?.duration)!)) % 60
        )
    }
    
    
    func pauseOrPlay() {
        if (isPlaying) {
            self.sound?.pause()
            self.isPlaying = false
        } else {
            self.sound?.play()
            self.isPlaying = true
            self.updateTime()
            self.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)

        }
    }
}
