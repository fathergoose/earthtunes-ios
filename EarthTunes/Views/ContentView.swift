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
        ScrollView() {
            VStack () {
                Text("Earthtunes").font(.title)
                VStack (alignment: .leading) {
                    StationView(downloader: downloader)
                    
                    DateAndTimeView(downloader: downloader)
                    
                    HStack {
                        Text("Duration").bold()
                        Divider()
                        TextField("Duration", text: $downloader.request.duration)
                            .keyboardType(.numberPad)
                            .fixedSize()
                            .multilineTextAlignment(.trailing)
                        Text("seconds")
                    }.padding()
                    
                    SonificationParamsView(downloader: downloader)
                }
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
        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
