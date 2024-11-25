//
//
// TaskStore.swift
// ToDoListApp
//
// Created by sturdytea on 22.11.2024.
//
// GitHub: https://github.com/sturdytea
//
    

import Foundation

class TaskStore {
    var tasks = [
        Task(id: 1, todo: "Почитать книгу", isCompleted: true, date: "22.11.2024", desc: "Составить список необходимых продуктов для ужина"),
        Task(id: 1, todo: "Уборка в квартире", isCompleted: false, date: "22.11.2024", desc: "Провести генеральную уборку в квартире"),
        Task(id: 1, todo: "Заняться спортом", isCompleted: false, date: "22.11.2024", desc: "Сходить в спортзал или сделать тренировку дома. Не забыть про разминку")
    ]
    
    func addTask(_ task: Task) {
        tasks.append(task)
    }
    
    func removeTask(_ task: Task) {
        if let index = tasks.firstIndex(where: { $0 as! AnyHashable == task as! AnyHashable}) {
            tasks.remove(at: index)
        }
    }
}
