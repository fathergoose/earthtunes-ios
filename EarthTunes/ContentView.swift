//
//  ContentView.swift
//  EarthTunes
//
//  Created by Al Ilseman on 11/23/19.
//  Copyright © 2019 Listening-To-The-Solid-Earth. All rights reserved.
//

import SwiftUI


struct ContentView: View {
    @ObservedObject var eventData: EventDownloader = EventDownloader()
    
    var body: some View {
        Button(action: eventData.getAndPlay) {
            Image(systemName: "triangle")
                .imageScale(.large)
                .accessibility(label: Text("Get Event"))
                .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
