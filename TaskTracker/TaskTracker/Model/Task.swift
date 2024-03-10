//
//  Task.swift
//  TaskTracker
//
//  Created by Глеб Писарев on 10.03.2024.
//

import Foundation

enum Priority: String, CaseIterable, Identifiable {
    case low = "Низкий"
    case normal = "Средний"
    case hight = "Высокий"
    
    init(_ int: Int64) {
        switch int {
        case 0:
            self = .low
        case 1:
            self = .normal
        default:
            self = .hight
        }
    }
    
    var toInt: Int64 {
        switch self {
        case .low:
            return 0
        case .normal:
            return 1
        case .hight:
            return 2
        }
    }
    
    var id: Self { self }
}

struct Task {
    let taskId: Int64
    let title: String
    let description: String
    let deadline: String
    let priority: Priority
}
