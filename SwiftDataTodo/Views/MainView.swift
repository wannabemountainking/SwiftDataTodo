//
//  MainView.swift
//  SwiftDataTodo
//
//  Created by YoonieMac on 3/12/26.
//

import SwiftUI
import SwiftData

struct MainView: View {
    
    @Query var tasks: [TaskModel]
    
    var body: some View {
        NavigationStack {
            ZStack {
                if tasks.isEmpty {
                    ContentUnavailableView("할 일이 없습니다",
                                           systemImage: "rectangle.and.pencil.and.ellipsis",
                                           description: Text("위의 추가 버튼을 눌러서 할 일을 적으세요 ☝️")
                    )
                } else {
                    List {
                        ForEach(tasks) { task in
                            TaskRowView()
                        }
                    } //:LIST
                } //:CONDITION
            } //:ZSTACK
            .navigationTitle("Todo List")
        } //:NAVIGATION
    }//:body
}

#Preview {
    MainView()
}
