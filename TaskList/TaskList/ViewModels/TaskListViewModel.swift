//
//  TaskListViewModel.swift
//  TaskListApp
//
//  Created by Anderson on 13/07/25.
//

import Foundation

class TaskListViewModel {
    private var tasks: [Task] = [
        Task(id: UUID(), title: "Uma hora de leitura", isCompleted: false),
        Task(id: UUID(), title: "Estudar Swift", isCompleted: true),
        Task(id: UUID(), title: "Fazer exercício", isCompleted: false)
    ]
    
    var onTasksUpdated: (([Task]) -> Void)?
    
    func loadTasks() {
        onTasksUpdated?(tasks)
    }
    
    func numberOfTasks() -> Int {
        return tasks.count
    }
    
    func task(at index: Int) -> Task {
        return tasks[index]
    }
    
    func addTask(title: String) {
        let task = Task(id: UUID(), title: title, isCompleted: false)
        tasks.append(task)
        onTasksUpdated?(tasks)
    }
}
