//
//  TaskManager.swift
//  TaskTracker
//
//  Created by Глеб Писарев on 10.03.2024.
//

import Foundation
import SQLite

enum TaskManagerError: Error {
    case pathNotCreated
    case taskNotInsert
    case dbNotConected
}

class TaskManager: ObservableObject {
    
    @Published var tasks: [Task]?
    
    let db: Connection
    
    let tasksTable = Table("tasks")
    let caregories = Table("caregories")
    let taskCategories = Table("task_categories")
    
    let taskId = Expression<Int64>("task_id")
    let title = Expression<String>("title")
    let description = Expression<String>("description")
    let deadline = Expression<String>("deadline")
    let priority = Expression<Int64>("priority")
    
    init() throws {
        guard let path = NSSearchPathForDirectoriesInDomains(
            .documentDirectory, .userDomainMask, true
        ).first else {
            throw TaskManagerError.pathNotCreated
        }
        do {
            db = try Connection("\(path)/db.sqlite3")
            
            try db.run(tasksTable.create(ifNotExists: true) { t in
                t.column(taskId, primaryKey: .autoincrement)
                t.column(title)
                t.column(description)
                t.column(deadline)
                t.column(priority)
            })
            tasks = fetchTasks()
        } catch {
            throw TaskManagerError.dbNotConected
        }
    }
    
    private func fetchTasks() -> [Task]? {
        return try? db.prepare(tasksTable).map { row in
            return Task(taskId: row[taskId],
                        title: row[title],
                        description: row[description],
                        deadline: row[deadline],
                        priority: Priority(row[priority]))
        }
    }
    
    func addTask(_ newTask: Task) throws {
        do {
            try db.run(tasksTable.insert(
                title <- newTask.title,
                description <- newTask.description,
                deadline <- newTask.deadline,
                priority <- newTask.priority.toInt
            ))
            tasks = fetchTasks()
        } catch {
            throw TaskManagerError.taskNotInsert
        }
    }
}
