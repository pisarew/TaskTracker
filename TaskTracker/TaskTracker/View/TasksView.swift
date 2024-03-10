//
//  TasksView.swift
//  TaskTracker
//
//  Created by Глеб Писарев on 10.03.2024.
//

import SwiftUI

protocol TaskInsertDelegate {
    func insert(_ newTask: Task)
}

struct TasksView: View {
    @ObservedObject var taskManager = try! TaskManager()
    
    var body: some View {
        NavigationStack {
            if let tasks = taskManager.tasks {
                List (tasks, id: \.taskId) { item in
                    VStack {
                        HStack {
                            Text(item.title)
                                .font(.headline)
                            Spacer()
                            if item.priority == .hight {
                                Image(systemName: "exclamationmark.triangle")
                                    .foregroundStyle(.red)
                            }
                            if item.priority == .normal {
                                Image(systemName: "exclamationmark.triangle")
                                    .foregroundStyle(.yellow)
                            }
                        }
                        HStack {
                            Text(item.description)
                            Spacer()
                            Text(item.deadline)
                        }
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                    }
                    .padding(.vertical, 2)
                }
                .navigationTitle("Задачи")
                .toolbar {
                    ToolbarItem(placement: .automatic) {
                        NavigationLink {
                            CreateTaskView(deligate: self)
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
            }
        }
        
    }
}

extension TasksView: TaskInsertDelegate {
    func insert(_ newTask: Task) {
        try? taskManager.addTask(newTask)
    }
    
}

#Preview {
    TasksView()
}
