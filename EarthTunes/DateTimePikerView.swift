//
//  DateTimePikerView.swift
//  EarthTunes
//
//  Created by Al Ilseman on 12/15/19.
//  Copyright © 2019 Listening-To-The-Solid-Earth. All rights reserved.
//

import SwiftUI

struct DateTimePikerView: View {
    @State var displayDatePicker = false
    @State var displayTimePicker = false

    var body: some View {
        Text("todo")
//        if (displayDatePicker) {
//            HStack {
//                DatePicker(
//                    "Start Date",
//                    selection: $downloader.request.startDate,
//                    in: dateRange,
//                    displayedComponents: .date
//                )
//
//                Spacer()
//
//                Button(action: {
//                    withAnimation {
//                        self.displayDatePicker.toggle()
//                    }
//                }) {
//                    Image(systemName: "chevron.right.circle")
//                        .imageScale(.large)
//                        .rotationEffect(.degrees(displayDatePicker ? 90 : 0))
//                        .scaleEffect(displayDatePicker ? 1.5 : 1)
//                        .padding()
//                }
//            }
//        } else {
//            HStack {
//                Text(dateString(downloader.request.startDate))
//
//                Spacer()
//
//                Button(action: {
//                    withAnimation {
//                        self.displayDatePicker.toggle()
//                    }
//                }) {
//                    Image(systemName: "chevron.right.circle")
//                        .imageScale(.large)
//                        .rotationEffect(.degrees(displayDatePicker ? 90 : 0))
//                        .scaleEffect(displayDatePicker ? 1.5 : 1)
//                        .padding()
//                }
//            }
//        }
//
//        DatePicker(
//            "Start Time",
//            selection: $downloader.request.startTime,
//            in: dateRange,
//            displayedComponents: .hourAndMinute
//        )
   }
}

struct DateTimePikerView_Previews: PreviewProvider {
    static var previews: some View {
        DateTimePikerView()
    }
}
