//
//  SonificationParamsView.swift
//  EarthTunes
//
//  Created by Al Ilseman on 1/26/20.
//  Copyright © 2020 Listening-To-The-Solid-Earth. All rights reserved.
//

import SwiftUI

struct SonificationParamsView: View {
    @ObservedObject var downloader: EventDownloader

    var body: some View {
        VStack (alignment: .leading){
            Text("Amplitude").font(.headline).padding(25)
            HStack {
                Divider()
                Picker(selection: $downloader.sonificationParams.amplitudeIndex, label: Text("")) {
                    ForEach(0 ..< downloader.sonificationParams.amplitudes.count) {
                        Text(String(self.downloader.sonificationParams.amplitudes[$0]))
                    }
                }
            }
            .padding()
            HStack {
                Text("Speed").bold()
                Divider()
                Picker(selection: $downloader.sonificationParams.speedIndex, label: Text("")) {
                    ForEach(0 ..< downloader.sonificationParams.factors.count) {
                        Text(self.downloader.sonificationParams.factors[$0].displayName)
                    }
                }
            }
            .padding()
        }
    }
}

//struct SonificationParamsView_Previews: PreviewProvider {
//    static var previews: some View {
//        SonificationParamsView()
//    }
//}
