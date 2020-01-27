//
//  EventParamsView.swift
//  EarthTunes
//
//  Created by Al Ilseman on 1/26/20.
//  Copyright © 2020 Listening-To-The-Solid-Earth. All rights reserved.
//

import SwiftUI

struct EventParamsView: View {
    @ObservedObject var downloader: EventDownloader

    var body: some View {
        VStack {
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
        }
    }
}

struct EventParamsView_Previews: PreviewProvider {
    static var previews: some View {
        EventParamsView(downloader: EventDownloader())
    }
}
