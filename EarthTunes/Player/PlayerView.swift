//
//  PlayerView.swift
//  EarthTunes
//
//  Created by Al Ilseman on 11/29/19.
//  Copyright © 2019 Listening-To-The-Solid-Earth. All rights reserved.
//

import SwiftUI
import AVFoundation

struct PlayerView : View {
    @ObservedObject var player: Player

    var body: some View {
        Button(action: {
            self.player.pauseOrPlay()
        }) {
            Image(systemName: player.isPlaying ? "pause.circle.fill" : "play.circle.fill").font(.title).frame(minWidth: 44, minHeight: 44)
        }
    }
}


struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView()
    }
}
