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
    @State private var isNewTask: Bool = false
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
                    )//: ContentUnavailableView
                } else {
                    List {
                        ForEach(sortedAndFilteredTodos) { task in
                            NavigationLink {
                                //destination
                                CreateUpdateTaskView(task: task)
                            } label: {
                                TaskRowView(task: task)
                                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                        Button {
                                            // action
                                            taskTodoDelete = task
                                            showAlert = true
                                        } label: {
                                            Label("Delete", systemImage: "trash")
                                                .font(.headline)
                                        }
                                        .tint(Color.red.opacity(0.8))
                                    }//: swipeAction: trailing (Delete)
                                    .swipeActions(edge: .leading, allowsFullSwipe: false) {
                                        Button {
                                            // action
                                            task.isComplete.toggle()
                                        } label: {
                                            Label(
                                                task.isComplete ? "Complete" : "OnGoing",
                                                systemImage: task.isComplete ? "arrow.uturn.backward.square" : "checkmark.square"
                                            )
                                            .font(.headline)
                                        }
                                        .tint(task.isComplete ? .green.opacity(0.8) : .blue.opacity(0.8))
                                    }//: .swipeAction: .leading (isImportant)
                            } //:NavLink
                        } //:LOOP
                    } //:LIST
                } //:CONDITION
            } //:VSTACK
            .navigationTitle(tasks.isEmpty ? "할 일 입력" : "할 일 목록")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        //action
                        sortOrder = (sortOrder == .forward) ? .reverse : .forward
                    } label: {
                        Image(systemName: "arrow.up.arrow.down.circle")
                            .font(.title2)
                            .symbolVariant(sortOrder == .forward ? .fill : .none)
                            .foregroundStyle(sortOrder == .forward ? Color.green : Color.red)
                    }
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        //action
                        filterOn.toggle()
                    } label: {
                        Image(systemName: "exclamationmark.triangle")
                            .font(.title2)
                            .symbolVariant(filterOn ? .fill : .none)
                            .foregroundStyle(filterOn ? Color.red : Color.gray)
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        //action
                        isNewTask.toggle()
                    } label: {
                        Image(systemName: "plus.app.fill")
                            .font(.title2)
                            .foregroundStyle(Color.blue.opacity(0.7))
                    }
                }
            }
            .sheet(isPresented: $isNewTask) {
                //dismiss
            } content: {
                NavigationStack {
                    CreateUpdateTaskView()
                }
            }
            .alert(
                "정말로 삭제하시겠습니까?",
                isPresented: $showAlert) {
                    Button("Delete", role: .destructive) {
                        guard let taskTodoDelete else {return}
                        modelContext.delete(taskTodoDelete)
                    }
                } message: {
                    Text("선택하신 할 일을 삭제하시겠습니까?")
                }
        } //:NAVIGATION
    }//:body
}

#Preview("Task 있음") {
    MainView()
        .modelContainer(TaskModel.previewTodo)
}

#Preview("Task 없음") {
    MainView()
}
