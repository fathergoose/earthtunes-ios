//
//  StationView.swift
//  EarthTunes
//
//  Created by Al Ilseman on 1/26/20.
//  Copyright © 2020 Listening-To-The-Solid-Earth. All rights reserved.
//

import SwiftUI

struct StationView: View {
    @ObservedObject var downloader: EventDownloader
    @State var showPicker = false

    var body: some View {
        VStack (alignment: .leading) {
            Text("Station").font(.subheadline).padding()
            HStack {

                if(!showPicker) {
                    Text(appLocations[downloader.request.stationIndex].name).padding()
                }
                
                Spacer()
                Button(action: {
                    withAnimation {
                        self.showPicker.toggle()
                    }
                }) {
                    Image(systemName: "chevron.right.circle")
                        .imageScale(.large)
                        .rotationEffect(.degrees(showPicker ? 90 : 0))
                        .scaleEffect(showPicker ? 1.5 : 1)
                        .padding()
                }
            }.padding()
            if (showPicker) {
                Picker(selection: $downloader.request.stationIndex, label: Text("")) {
                    ForEach(0 ..< appLocations.count) {
                        Text(appLocations[$0].name)
                    }
                }.labelsHidden()
            }
        }
    }
}


struct StationView_Previews: PreviewProvider {
    static var previews: some View {
        StationView(downloader: EventDownloader())
    }
}
