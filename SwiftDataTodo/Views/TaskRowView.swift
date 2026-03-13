//
//  TaskRowView.swift
//  SwiftDataTodo
//
//  Created by YoonieMac on 3/13/26.
//

import SwiftUI

struct TaskRowView: View {
    
    let task: TaskModel
    
    var body: some View {
        HStack {
            VStack(spacing: 10) {
                Text(task.taskName)
                Text(task.dateFormatted(date: task.dueDate))
            }
            Spacer()
            LabeledContent {
                //content (view)
                Text(task.isImportant ? "중요" : "")
            } label: {
                Image(systemName: "exclamationmark.triangle")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .tint(.red)
            }

        }
    }
}

#Preview {
    TaskRowView(task: <#TaskModel#>)
}
