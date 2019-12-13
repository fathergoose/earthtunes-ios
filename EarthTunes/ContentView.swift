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
    
    var dateRange: ClosedRange<Date> {
        let min = Calendar.current.date(byAdding: .year, value: -20, to: Date())!
        let max = Date()
        return min...max
    }

    
    var body: some View {
        VStack {
            Picker(selection: $downloader.request.stationIndex, label: Text("Station")) {
                ForEach(0 ..< appLocations.count) {
                    Text(appLocations[$0].name)
                }
            }
            VStack {
                DatePicker(
                    "Start Date",
                    selection: $downloader.request.startDate,
                    in: dateRange,
                    displayedComponents: .date
                )
                DatePicker(
                    "Start Time",
                    selection: $downloader.request.startTime,
                    in: dateRange,
                    displayedComponents: .hourAndMinute
                )
                HStack {
                    Text("Duration").bold()
                    Divider()
                    TextField("Duration", text: $downloader.request.duration).keyboardType(.numberPad)
                }
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
        }.padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
