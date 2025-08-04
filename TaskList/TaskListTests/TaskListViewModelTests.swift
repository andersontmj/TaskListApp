//
//  TaskListViewModelTests.swift
//  TaskListAppTests
//
//  Created by Anderson on 13/07/25.
//

import XCTest
@testable import TaskList

final class TaskListViewModelTests: XCTestCase {
    var viewModel: TaskListViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = TaskListViewModel()
    }
    
    func testNumberOfTasks() {
        viewModel.clearAllTasks()
        XCTAssertEqual(viewModel.numberOfTasks(), 0, "Deve retornar 0 após limpar")
        viewModel.addTask(title: "Nova tarefa")
        XCTAssertEqual(viewModel.numberOfTasks(), 1, "Deve retornar 1 tarefa")
    }
    
    func testTaskAtIndex() {
        viewModel.addTask(title: "Estudar Swift")
        let index = viewModel.numberOfTasks() - 1
        let task = viewModel.task(at: index)
        XCTAssertEqual(task.title, "Estudar Swift", "Deve retornar a tarefa correta")
    }
    
    func testAddTask() {
        let numberOfTasks = viewModel.numberOfTasks()
        viewModel.addTask(title: "Nova tarefa")
        XCTAssertNotEqual(viewModel.numberOfTasks(), numberOfTasks, "Deve adicionar uma nova tarefa")
        let newTask = viewModel.task(at: numberOfTasks)
        XCTAssertEqual(newTask.title, "Nova tarefa", "Titulo deve ser correto")
        XCTAssertFalse(newTask.isCompleted, "Nova tarefa deve estar não concluída")
    }
    
    func testToggleTaskCompletion() {
        let task = viewModel.task(at: 1)
        let initialState = task.isCompleted
        viewModel.toggleTaskCompletion(at: 1)
        XCTAssertEqual(viewModel.task(at: 1).isCompleted, !initialState, "Estado deve alternar")
    }

    func testDeleteTask() {
        let numberOfTasks = viewModel.numberOfTasks()
        viewModel.deleteTask(at: 0)
        XCTAssertNotEqual(viewModel.numberOfTasks(), numberOfTasks, "Deve remover uma tarefa")
    }
    
    func testClearAllTaks() {
        viewModel.clearAllTasks()
        XCTAssertEqual(viewModel.numberOfTasks(), 0, "Deve retornar que a lista de tarefas está vazia")
    }
    
    func testUpdateTask() {
        viewModel.clearAllTasks()
        viewModel.addTask(title: "Nova tarefa")
        XCTAssertEqual(viewModel.task(at: 0).title, "Nova tarefa", "Deve retornar a tarefa recém-criada")
        viewModel.updateTask(at: 0, withTitle: "Nova tarefa atualizada")
        XCTAssertEqual(viewModel.task(at: 0).title, "Nova tarefa atualizada", "Deve retornar a tarefa com o título atualizado")
    }
}
