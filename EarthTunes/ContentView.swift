//
//  ContentView.swift
//  EarthTunes
//
//  Created by Al Ilseman on 11/23/19.
//  Copyright © 2019 Listening-To-The-Solid-Earth. All rights reserved.
//

import SwiftUI


struct Todo: Codable, Identifiable {
    let userId, id: Int
    let title: String
    let completed: Bool

    enum CodingKeys: CodingKey {
        case userId, id, title, completed
    }
}

typealias Todos = [Todo]


struct ContentView: View {
    @ObservedObject var todoData: TodoDownloader = TodoDownloader()
//
//    var body: some View {
//        NavigationView {
//            List(self.todoData.todos) { todo in
////                NavigationLink(destination: TodoDetail(todo: todo)) {
//                    Text(todo.title)
////                }
//            }
//        .navigationBarTitle(Text("To Do List"))
//        }
//    }
    var body: some View {
        Text("helo al")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
