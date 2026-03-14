//
//  MainView.swift
//  SwiftDataTodo
//
//  Created by YoonieMac on 3/12/26.
//

import SwiftUI
import SwiftData

struct MainView: View {
    
    // MARK: - Properties
    @Environment(\.modelContext) private var modelContext
    @Query private var tasks: [TaskModel]
    @State private var showAlert: Bool = false
    @State private var taskTodoDelete: TaskModel?
    @State private var isNewTask: Bool = true
    @State private var sortOrder: SortOrder = .forward
    @State private var filterOn: Bool = false
    
    // MARK: - Computed Property
    private var sortedAndFilteredTodos: [TaskModel] {
        let todos: [TaskModel] = filterOn ? tasks.filter { $0.isImportant } : tasks
        return todos.sorted { sortOrder == .forward ? $0.taskName < $1.taskName : $0.taskName > $1.taskName }
    }
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            VStack {
                if tasks.isEmpty {
                    ContentUnavailableView(
                        "해야 할 일 없음",
                        systemImage: "rectangle.and.pencil.and.ellipsis",
                        description:
                            Text("☝️ 위의 추가 버튼을 클릭해서 해야할 일을 작성하세요.")
                            .font(.title3)
                    )
                }
            }
            .navigationTitle(tasks.isEmpty ? "할 일 입력" : "할 일 목록")
        } //:NAVIGATION
    }//:body
}

#Preview {
    MainView()
}
