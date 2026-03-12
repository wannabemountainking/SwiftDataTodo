//
//  SwiftDataTodoApp.swift
//  SwiftDataTodo
//
//  Created by YoonieMac on 3/12/26.
//

import SwiftUI
import SwiftData

@main
struct SwiftDataTodoApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
                .modelContainer(for: TaskModel.self)
        }
    }
}
