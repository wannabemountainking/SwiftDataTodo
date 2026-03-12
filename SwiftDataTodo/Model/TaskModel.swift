//
//  TaskModel.swift
//  SwiftDataTodo
//
//  Created by YoonieMac on 3/12/26.
//

import Foundation
import SwiftData


@Model
class TaskModel {
    var taskName: String
    var isComplete: Bool
    var isImportant: Bool
    var dueDate: Date?
    
    init(taskName: String, isComplete: Bool = false, isImportant: Bool, dueDate: Date? = nil) {
        self.taskName = taskName
        self.isComplete = isComplete
        self.isImportant = isImportant
        self.dueDate = dueDate
    }
}


// Preview용 ModelContainer 생성하기

extension TaskModel {
    
    @MainActor
    static var taskContainerForPreview: ModelContainer {
        let container: ModelContainer
        
        // container 만들기
        do {
            container = try ModelContainer(for: TaskModel.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        } catch {
            fatalError("Failed to Create ModelContainer for Preview: \(error)")
        }
        
        // mainContext에 넣기
        container.mainContext.insert(TaskModel(taskName: "집 청소하기", isImportant: false))
        container.mainContext.insert(TaskModel(taskName: "SwiftUI 강의 듣기", isImportant: true))
        
        let duedateTask = TaskModel(taskName: "Javascript 연습하기", isImportant: true)
        duedateTask.dueDate = dateFormatter().date(from: "26년 03월 11일")
        container.mainContext.insert(duedateTask)
        let completedTask = TaskModel(taskName: "빨래하기", isComplete: true, isImportant: false)
        container.mainContext.insert(completedTask)
        
        // mainContext에 저장하기
        try? container.mainContext.save()
        
        return container
    }
    
    func dateFormatted(date: Date?) -> String {
        TaskModel.dateFormatter().string(from: date ?? Date())
    }
    
    static func dateFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy년 MM월 dd일"
        return formatter
    }
}
