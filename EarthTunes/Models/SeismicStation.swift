//
//  SeismicStation.swift
//  EarthTunes
//
//  Created by Al Ilseman on 12/2/19.
//  Copyright © 2019 Listening-To-The-Solid-Earth. All rights reserved.
//

import Foundation

struct SeismicStation : Hashable {
    var networkCode: String
    var stationCode: String
    var locationCode: String
    var channel: Channels
    var displayName: String
}


enum Channels: String {
    case HHZ
    case BHZ
}
