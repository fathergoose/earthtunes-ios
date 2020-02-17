//
//  SavedFilesView.swift
//  EarthTunes
//
//  Created by Al Ilseman on 1/27/20.
//  Copyright © 2020 Listening-To-The-Solid-Earth. All rights reserved.
//

import SwiftUI

struct SavedFilesView: View {
    var documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    func fileList() -> [String] {
        if let files = try? FileManager.default.contentsOfDirectory(at: documentsURL, includingPropertiesForKeys: nil) {
            return files.map {$0.lastPathComponent}
        }
        return ["empty"]
    }

    var body: some View {
        List {
            ForEach(fileList(), id: \.self) { file in
                Text(file)
            }
        }
    }
}

struct SavedFilesView_Previews: PreviewProvider {
    static var previews: some View {
        SavedFilesView()
    }
}
