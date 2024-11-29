//
//
// CoreDataManagerTests.swift
// ToDoListApp
//
// Created by sturdytea on 29.11.2024.
//
// GitHub: https://github.com/sturdytea
//
    

import XCTest
@testable import ToDoListApp

final class CoreDataManagerTests: XCTestCase {
    
    private var coreDataManager: CoreDataManager!
    private var testStack: MockCoreDataStack!

    override func setUp() {
        super.setUp()
        coreDataManager = CoreDataManager.shared
        testStack = MockCoreDataStack()
        let testContext = testStack.context
        coreDataManager.context = testContext
    }

    override func tearDown() {
        coreDataManager = nil
        testStack = nil
        super.tearDown()
    }

    func testCreateTask() {
        let title = "Task to Create"
        coreDataManager.createTask(title: title)
        let tasks = coreDataManager.getTasks()
        XCTAssertEqual(tasks.count, 1)
        XCTAssertEqual(tasks.first?.todo, title)
    }

    func testDeleteTask() {
        let title = "Task to Delete"
        coreDataManager.createTask(title: title)
        guard let task = coreDataManager.getTasks().first else { return }
        coreDataManager.deleteTask(entity: task)
        
        let tasks = coreDataManager.getTasks()
        XCTAssertEqual(tasks.count, 0)
    }
    
    func testUpdateTask() {
        let title = "Task to Update"
        let newTitle = "Updated Task"
        coreDataManager.createTask(title: title)
        guard let task = coreDataManager.getTasks().first else { return }
        coreDataManager.updateTask(entity: task, newName: newTitle)
        
        XCTAssertEqual(task.todo, newTitle)
    }
}
