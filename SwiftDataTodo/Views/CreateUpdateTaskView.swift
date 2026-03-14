//
//  CreateUpdateTaskView.swift
//  SwiftDataTodo
//
//  Created by YoonieMac on 3/13/26.
//

import SwiftUI
import SwiftData

struct CreateUpdateTaskView: View {
    
    // MARK: - Properties
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var taskName: String = ""
    @State private var isImportant: Bool = false
    @State private var dueDate: Date = Date()
    @State private var hasDueDate: Bool = false
    
    var task: TaskModel?
    var isNewTask: Bool { task == nil }
    
    var body: some View {
        Form {
            LabeledContent {
                //contentView
                TextField("할 일을 입력하세요", text: $taskName)
                    
            } label: {
                Text("해야할 일")
            }

        }
    }
}

#Preview {
    CreateUpdateTaskView()
}
