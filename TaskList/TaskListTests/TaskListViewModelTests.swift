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
        let viewModel = TaskListViewModel()
        XCTAssertEqual(viewModel.numberOfTasks(), 3, "Deve retornar 3 tarefas")
    }
    
    func testTaskAtIndex() {
        let task = viewModel.task(at: 1)
        XCTAssertEqual(task.title, "Estudar Swift", "Deve retornar a tarefa correta")
    }
    
    func testAddTask() {
        viewModel.addTask(title: "Nova tarefa")
        XCTAssertEqual(viewModel.numberOfTasks(), 4, "Deve adicionar uma nova tarefa")
        let newTask = viewModel.task(at: 3)
        XCTAssertEqual(newTask.title, "Nova tarefa", "Titulo deve ser correto")
        XCTAssertFalse(newTask.isCompleted, "Nova tarefa deve estar não concluída")
    }

}
