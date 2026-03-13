//
//  TaskModel.swift
//  SwiftDataTodo
//
//  Created by YoonieMac on 3/12/26.
//

import Foundation
import SwiftData


@Model
final class TaskModel {
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

// preview 전용의 TaskModel(데이터를 넣은 상태)

@MainActor
extension TaskModel {
    
    static var previewTodo: ModelContainer {
        let container: ModelContainer
        do {
            container = try ModelContainer(for: TaskModel.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        } catch {
            fatalError("Error on Generating ModelContainer for Preview")
        }
        
        container.mainContext.insert(TaskModel(taskName: "집 청소하기", isImportant: false))
        container.mainContext.insert(TaskModel(taskName: "SwiftUI 강의 듣기", isImportant: true))
        
        let todoWithDueDate = TaskModel(taskName: "Javascript 연습하기", isImportant: true)
        todoWithDueDate.dueDate = dateFormatter().date(from: "24년 07월 05일")
        container.mainContext.insert(todoWithDueDate)
        
        let todoWithIsComplete = TaskModel(taskName: "빨래하기",isComplete: true, isImportant: false)
        container.mainContext.insert(todoWithIsComplete)
        
        // 잊기 쉬운 mainContext의 저장
        try? container.mainContext.save()
        
        return container
    }
    
    func formattedDueDate() -> String {
        TaskModel.dateFormatter().string(from: self.dueDate ?? Date())
    }
    
    static func dateFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy년 MM월 dd일"
        return formatter
    }
}
