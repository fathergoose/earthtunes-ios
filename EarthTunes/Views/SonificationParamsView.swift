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
    @State var showAmpPicker = false
    @State var showSpeedPicker = false

    var body: some View {
        VStack {
            HStack {
                Text("Amplitude").font(.headline).padding()
                
                Spacer()
                Button(action: {
                    withAnimation {
                        self.showAmpPicker.toggle()
                        self.showSpeedPicker = false
                    }
                }) {
                    Image(systemName: "chevron.right.circle")
                        .imageScale(.large)
                        .rotationEffect(.degrees(showAmpPicker ? 90 : 0))
                        .scaleEffect(showAmpPicker ? 1.5 : 1)
                        .padding()
                }
            }.padding()
            if (showAmpPicker) {
                Picker(selection: $downloader.sonificationParams.amplitudeIndex, label: Text("Scale").padding()) {
                    ForEach(0 ..< downloader.sonificationParams.amplitudes.count) {
                        Text(String(self.downloader.sonificationParams.amplitudes[$0]))
                    }
                }
            }
            HStack {
                Text("Speed").font(.headline).padding()
                Spacer()
                Button(action: {
                    withAnimation {
                        self.showSpeedPicker.toggle()
                        self.showAmpPicker = false
                    }
                }) {
                    Image(systemName: "chevron.right.circle")
                        .imageScale(.large)
                        .rotationEffect(.degrees(showSpeedPicker ? 90 : 0))
                        .scaleEffect(showSpeedPicker ? 1.5 : 1)
                        .padding()
                }
            }.padding()
            if (showSpeedPicker) {
                Picker(selection: $downloader.sonificationParams.speedIndex, label: Text("Rate").padding(5)) {
                        ForEach(0 ..< downloader.sonificationParams.factors.count) {
                            Text(self.downloader.sonificationParams.factors[$0].displayName)
                        }
                }.padding()
            }
        }
    }
}

struct SonificationParamsView_Previews: PreviewProvider {
    static var previews: some View {
        SonificationParamsView(downloader: EventDownloader())
    }
}
