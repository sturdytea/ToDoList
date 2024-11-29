//
//
// LocalizedContent.swift
// ToDoListApp
//
// Created by sturdytea on 25.11.2024.
//
// GitHub: https://github.com/sturdytea
//
    

import Foundation

enum LocalizedContent {
    static let largeTitle = "Задачи"
    
    enum Counter {
        static let oneTask = "Задача"
        static let twoToFourTasks = "Задачи"
        static let multipleTasks = "Задач"
    }
    
    enum Placeholder {
        static let title = "Заголовок"
        static let desc = "Здесь можно добавить описание..."
        static let searchBar = "Поиск"
    }
    
    enum MenuOption {
        static let edit = "Редактировать"
        static let share = "Поделиться"
        static let delete = "Удалить"
    }
}
