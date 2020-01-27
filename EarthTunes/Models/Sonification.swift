//
//  Sonification.swift
//  EarthTunes
//
//  Created by Al Ilseman on 11/29/19.
//  Copyright © 2019 Listening-To-The-Solid-Earth. All rights reserved.
//

import Foundation

struct Sonification {
    var event: SeismicEvent
    var samples: [Double]
    var params: SonificationParams


    
    
    init(seismicEvent: SeismicEvent, parameters: SonificationParams) {
        event = seismicEvent
        params = parameters
        
        let fixedAmp = 5e-5 / Double(params.amplitudes[params.amplitudeIndex])

        let halfPi = Double.pi / 2
        let thirtyTwoBits = pow(2.0, 31.0)
        let multiplier = thirtyTwoBits / halfPi

        samples = event.data.map{
            atan( ( $0 )/fixedAmp) * multiplier
        }
    }
    
    func sampleRate() -> Double {
        return event.sampleRate! * params.factors[params.speedIndex].value
    }
}

struct SonificationParams {
    let factors = [
        SpeedFactor(displayName: "Low", value: 400),
        SpeedFactor(displayName: "Medium", value: 800),
        SpeedFactor(displayName: "High", value: 1600)
    ]
    let amplitudes = Array(1...10)
    var speedIndex = 1
    var amplitudeIndex = 0

    var amplitudeScale: String = "1"
}

struct SpeedFactor {
    let displayName: String
    let value: Double
}
