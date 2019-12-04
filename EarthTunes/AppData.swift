//
//  Data.swift
//  EarthTunes
//
//  Created by Al Ilseman on 12/2/19.
//  Copyright © 2019 Listening-To-The-Solid-Earth. All rights reserved.
//

import Foundation

let stationList: [SeismicStation] = [
//  SeismicStation(networkCode: "TA", stationCode: "L44A", locationCode: nil, displayName: "Ryerson"), // < Feb '19
//  SeismicStation(networkCode: "NW", stationCode: "L44A", locationCode: nil, channel: Channels.HHZ, displayName: "Ryerson"), // > Feb '19
    SeismicStation(networkCode: "JP", stationCode: "JOW", locationCode: "--", channel: Channels.BHZ, displayName: "JP-JOW"),
    SeismicStation(networkCode: "GT", stationCode: "VNDA", locationCode: "00", channel: Channels.BHZ, displayName: "GT-VNDA"),
    SeismicStation(networkCode: "GE", stationCode: "SNAA", locationCode: "--", channel: Channels.BHZ, displayName: "GE-SNAA"),
    SeismicStation(networkCode: "NZ", stationCode: "KHZ", locationCode: "10", channel: Channels.HHZ, displayName: "NZ-KHZ"),
    SeismicStation(networkCode: "IU", stationCode: "PAB", locationCode: "00", channel: Channels.BHZ, displayName: "IU-PAB"),
    SeismicStation(networkCode: "IC", stationCode: "QIZ", locationCode: "10", channel: Channels.HHZ, displayName: "IC-QIZ"),
    SeismicStation(networkCode: "IU", stationCode: "LSZ", locationCode: "10", channel: Channels.BHZ, displayName: "IU-LSZ"),
    SeismicStation(networkCode: "II", stationCode: "PFO", locationCode: "10", channel: Channels.BHZ, displayName: "II-PFO"),
    SeismicStation(networkCode: "II", stationCode: "MSEY", locationCode: "10", channel: Channels.BHZ, displayName: "II-MSEY"),
    SeismicStation(networkCode: "CN", stationCode: "GAC", locationCode: "--", channel: Channels.BHZ, displayName: "CN-GAC"),
    SeismicStation(networkCode: "IU", stationCode: "CASY", locationCode: "10", channel: Channels.BHZ, displayName: "Iu-CASY")
]




/*
 Finding 10 stations was much harder than I thought primarily because stations get upgrades that change the channel or location codes, or they do not have continuous data for a decent time period (at least a decade).  Here is a list that will work:

 Suzan 11:39 PM
 
 net sta loc ch
 JP  JOW -- BHZ
 GT  VNDA 00 BHZ
 GE  SNAA -- BHZ
 NZ  KHZ 10 HHZ
 IU  PAB 00 BHZ
 IC  QIZ 10 HHZ
 IU  LSZ 10 BHZ
 II  PFO 10 BHZ
 II  MSEY 10 BHZ
 CN  GAC -- BHZ
 IU  CASY 10 BHZ
 TA  L44A -- BHZ
 There are 12 stations on the list. The first column is network code, the 2nd is stations code/name, the 3rd is location code, the 4th is channel name.  The last one (L44A in Ryerson) only works through the end of February 2019. For data after March 2019, we need to use
 NW L44A 00 HHZ
 For each of these stations the sampling rate is different and would need to be read in from the header line of each text file one gets from the web service.

 */
