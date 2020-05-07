//
//  TodoManager.swift
//  TodoList
//
//  Created by Apple on 2020/05/07.
//  Copyright © 2020 com.joonwon. All rights reserved.
//
import Foundation
import UIKit

class TodoManager {
    
    //싱글톤
    static let shared = TodoManager()
    
    static var lastId: Int = 0
    
    var todos: [Todo] = []
    
    func createTodo(detail: String, isToday: Bool) -> Todo {
        //TODO: create로직 추가
        let nextId = TodoManager.lastId + 1
        TodoManager.lastId = nextId
        return Todo(id: 1, isDone: false, detail: detail, isToday: isToday)
    }
    
    func addTodo(_ todo: Todo) {
        //TODO: add로직 추가
        todos.append(todo)
        saveTodo()
    }
    
    func deleteTodo(_ todo: Todo) {
        //TODO: delete 로직 추가
        
        todos = todos.filter { $0.id != todo.id }
        saveTodo()
        //방대한 데이터일 경우 이게 더 효율적일 수 있음
//        if let index = todos.firstIndex(of: todo) {
//            todos.remove(at: index)
//        }
        
    }
    
    func updateTodo(_ todo: Todo) {
        //TODO: updatee 로직 추가
        guard let index = todos.firstIndex(of: todo) else { return }
        todos[index].update(isDone: todo.isDone, detail: todo.detail, isToday: todo.isToday)
        saveTodo()
        
    }
    
    func saveTodo() {
        Storage.store(todos, to: .documents, as: "todos.json")
    }
    
    func retrieveTodo() {
        todos = Storage.retrive("todos.json", from: .documents, as: [Todo].self) ?? []
        
        let lastId = todos.last?.id ?? 0
        TodoManager.lastId = lastId
    }
}
