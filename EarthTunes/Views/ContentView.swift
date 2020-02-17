//
//  ContentView.swift
//  EarthTunes
//
//  Created by Al Ilseman on 11/23/19.
//  Copyright © 2019 Listening-To-The-Solid-Earth. All rights reserved.
//

import SwiftUI
import UIKit

struct ContentView: View {
    @ObservedObject var downloader: EventDownloader = EventDownloader()
    
    
    
    
    
    var body: some View {
        NavigationView {
            ScrollView() {
                VStack () {
                    Text("Earthtunes").font(.title)
                    VStack (alignment: .leading) {
                        Text("Seismic Event").font(.headline)
                        EventParamsView(downloader: downloader)
                        SonificationParamsView(downloader: downloader)
                    }
                    Button(action: downloader.getAndSave) {
                        Image(systemName: "triangle")
                            .imageScale(.large)
                            .accessibility(label: Text("Get Event"))
                            .padding()
                    }
                    
                    Text(downloader.status)
                    
                    NavigationLink(destination: SavedAudio()) {
                        Text("Go Files")
                    }
                    
                    
                    
                    if (downloader.soundFile != nil){
                        HStack {
                            Button(action: downloader.soundFile!.saveExportFile) {
                                Text("Save")
                            }
                            Spacer()
                            PlayerView(player: Player(source_url: downloader.soundFile!.tempURL))
                        }
                    }
                }
            }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
