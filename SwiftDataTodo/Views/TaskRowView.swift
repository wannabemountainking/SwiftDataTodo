//
//  TaskRowView.swift
//  SwiftDataTodo
//
//  Created by YoonieMac on 3/13/26.
//

import SwiftUI
import SwiftData

struct TaskRowView: View {
    
    let task: TaskModel
    
    var body: some View {
        
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                HStack(spacing: 30) {
                    Text(task.taskName)
                        .font(.title2)
                        .strikethrough(task.isComplete, color: .red)
                    Image(systemName: task.isImportant ? "exclamationmark.triangle.fill" : "")
                        .font(.title2)
                        .foregroundStyle(.red)
                    Spacer()
                }
                Text(task.formattedDueDate())
                    .font(.subheadline)
            }
        }
        .padding(.horizontal)
        
    }//:body
}

#Preview {
    
    let _ = TaskModel.previewTodo
    let task = TaskModel(taskName: "완료된 일", isComplete: true, isImportant: true, dueDate: .now)
    
    TaskRowView(task: task)
}
