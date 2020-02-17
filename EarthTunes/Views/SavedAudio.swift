//
//  SavedAudio.swift
//  EarthTunes
//
//  Created by Al Ilseman on 2/16/20.
//  Copyright © 2020 Listening-To-The-Solid-Earth. All rights reserved.
//

import SwiftUI
import Foundation


struct SavedAudio: View {
    var body: some View {
        List {
            ForEach(FileManager.default.urls(for: .documentDirectory), id: \.self) { url in
                Text(url.lastPathComponent)
            }
        }
    }
}

struct SavedAudio_Previews: PreviewProvider {
    static var previews: some View {
        SavedAudio()
    }
}

extension FileManager {
    func urls(for directory: FileManager.SearchPathDirectory, skipsHiddenFiles: Bool = true ) -> [URL] {
        let documentsURL = urls(for: directory, in: .userDomainMask)[0]
        let fileURLs = try? contentsOfDirectory(at: documentsURL, includingPropertiesForKeys: nil, options: skipsHiddenFiles ? .skipsHiddenFiles : [] )
        return fileURLs!
    }
}
