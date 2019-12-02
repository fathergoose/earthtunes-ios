//
//  ContentView.swift
//  EarthTunes
//
//  Created by Al Ilseman on 11/23/19.
//  Copyright © 2019 Listening-To-The-Solid-Earth. All rights reserved.
//

import SwiftUI


struct ContentView: View {
    @ObservedObject var downloader: EventDownloader = EventDownloader()
    
    var body: some View {
        VStack {
            Button(action: downloader.getAndSave) {
                Image(systemName: "triangle")
                    .imageScale(.large)
                    .accessibility(label: Text("Get Event"))
                    .padding()
            }

            Text(downloader.status)
            if (downloader.soundFile != nil){
                PlayerView(player: Player(source_url: downloader.soundFile!.url))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
