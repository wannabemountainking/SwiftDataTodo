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
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
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
                    .font(.title)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal, 5)
            } label: {
                Text("TITLE")
                    .font(.title)
            }//: LabeledContent
            
            VStack(alignment: .leading, spacing: 20) {
                Label("IS IMPORTANT", systemImage: "exclamationmark.triangle")
                    .font(.title3)
                Picker("", selection: $isImportant) {
                    Text("YES").tag(true)
                    Text("NO").tag(false)
                }//: Picker
                .pickerStyle(.segmented)
                
                Divider()
                
                Toggle(isOn: $hasDueDate) {
                    Label("HAS DUE DATE", systemImage: "calendar")
                        .font(.title3)
                }//: Toggle
                if hasDueDate {
                    DatePicker(
                        "",
                        selection: $dueDate,
                        displayedComponents: [.date]
                    )//: DatePicker
                    .datePickerStyle(.graphical)
                } //:CONDITION
                
                HStack(spacing: 20) {
                    Button {
                        //action
                        if isNewTask {
                            let newTask = TaskModel(
                                taskName: taskName,
                                isImportant: isImportant,
                                dueDate: hasDueDate ? dueDate : nil
                            )
                            modelContext.insert(newTask)
                        } else {
                            task?.taskName = taskName
                            task?.isImportant = isImportant
                            task?.dueDate = hasDueDate ? dueDate : nil
                        }
                        dismiss()
                    } label: {
                        Text(isNewTask ? "ADD" : "UPDATE")
                            .font(.title2.bold())
                            .foregroundStyle(.white)
                            .frame(height: 40)
                            .frame(maxWidth: .infinity)
                            .background(Color.green.opacity(0.8))
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                    }
                    .disabled(taskName.isEmpty)
                    
                    Button {
                        //action
                        dismiss()
                    } label: {
                        Text("CANCEL")
                            .font(.title2.bold())
                            .foregroundStyle(.white)
                            .frame(height: 40)
                            .frame(maxWidth: .infinity)
                            .background(Color.red.opacity(0.8))
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                    }
                } //:HSTACK
            } //:VSTACK
        }//: Form
        .task {
            if let task {
                self.taskName = task.taskName
                self.isImportant = task.isImportant
                self.hasDueDate = task.dueDate != nil
                self.dueDate = task.dueDate ?? Date()
            }
        }
        .navigationTitle(isNewTask ? "ADD TASK" : "UPDATE TASK")
        .navigationBarTitleDisplayMode(.inline)
    }//:body
}

#Preview("ADD TASK") {
    CreateUpdateTaskView()
        .modelContainer(TaskModel.previewTodo)
}

#Preview("EDIT TASK") {
    
    let _ = TaskModel.previewTodo
    
    let taskModel = TaskModel(
        taskName: "SwiftUI 여러가지 만들기",
        isComplete: false,
        isImportant: true,
        dueDate: TaskModel.dateFormatter().date(from: "13년 03월 24일")
    )
    
    CreateUpdateTaskView(task: taskModel)
}
