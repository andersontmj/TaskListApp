//
//  TaskListViewModel.swift
//  TaskListApp
//
//  Created by Anderson on 13/07/25.
//

import Foundation

enum TaskUpdate {
    case added(IndexPath)
    case deleted(IndexPath)
    case updated(IndexPath)
    case deletedMultiple([IndexPath])
    case reloaded
}

class TaskListViewModel {
    private var tasks: [Task] = []
    private let tasksKey = "tasks"
    var onTasksUpdated: (([Task], TaskUpdate) -> Void)?
    
    init() {
        if let data = UserDefaults.standard.data(forKey: tasksKey),
           let savedTasks = try? JSONDecoder().decode([Task].self, from: data) {
            tasks = savedTasks
        } else {
            tasks = [
                Task(id: UUID(), title: "Comprar leite", isCompleted: false),
                Task(id: UUID(), title: "Estudar Swift", isCompleted: true),
                Task(id: UUID(), title: "Fazer exercício", isCompleted: false)
            ]
            saveTasks()
        }
    }
    
    func saveTasks() {
        if let data = try? JSONEncoder().encode(tasks) {
            UserDefaults.standard.set(data, forKey: tasksKey)
        }
    }
    
    func loadTasks() {
        onTasksUpdated?(tasks, .reloaded)
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
        saveTasks()
        onTasksUpdated?(tasks, .added(IndexPath(row: tasks.count - 1, section: 0)))
    }
    
    func updateTask(at index: Int, withTitle title: String) {
        tasks[index].title = title
        saveTasks()
        onTasksUpdated?(tasks, .updated(IndexPath(row: index, section: 0)))
    }
    
    func deleteTask(at index: Int) {
        tasks.remove(at: index)
        saveTasks()
        onTasksUpdated?(tasks, .deleted(IndexPath(row: index, section: 0)))
    }
    
    func toggleTaskCompletion(at index: Int) {
        tasks[index].isCompleted.toggle()
        saveTasks()
        onTasksUpdated?(tasks, .updated(IndexPath(row: index, section: 0)))
    }
    
    func clearAllTasks() {
        let indexPaths = tasks.indices.map { IndexPath(row: $0, section: 0) }
        tasks.removeAll()
        saveTasks()
        onTasksUpdated?(tasks, .deletedMultiple(indexPaths))
    }
}
