//
//  CreateTaskView.swift
//  TaskTracker
//
//  Created by Глеб Писарев on 10.03.2024.
//

import SwiftUI

struct CreateTaskView: View {
    
    var deligate: TaskInsertDelegate?
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var deadline = Date()
    @State private var selectedPriority: Priority = .low
    
    var body: some View {
        VStack {
            Text("Новая задача")
                .font(.title)

            Spacer()
            
            TextField("Название", text: $title)
            TextField("Описание", text: $description)
            
            DatePicker("Дедлайн",
                       selection: $deadline,
                       displayedComponents: [.date, .hourAndMinute])
            
            Text("Приоритет задачи")
                .padding()
            Picker("Приоритет", selection: $selectedPriority) {
                ForEach(Priority.allCases) { priority in
                    Text(priority.rawValue.capitalized)
                }
            }
            
            Spacer()
            
            Button {
                let formater = DateFormatter()
                formater.dateStyle = .short
                let newTask = Task(taskId: 1,
                                   title: title,
                                   description: description,
                                   deadline: formater.string(from: deadline),
                                   priority: selectedPriority)
                deligate?.insert(newTask)
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Сохранить")
                    .foregroundStyle(.white)
                    .padding(.horizontal, 30)
                    .padding(.vertical, 8)
                    .background(RoundedRectangle(cornerRadius: 10))
                    .foregroundStyle(.green)
            }
        }
        .textFieldStyle(.roundedBorder)
        .pickerStyle(.segmented)
        .padding(20)
    }
}

#Preview {
    CreateTaskView()
}
