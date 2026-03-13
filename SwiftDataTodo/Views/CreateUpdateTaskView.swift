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
        
    }
}

#Preview {
    CreateUpdateTaskView()
}
