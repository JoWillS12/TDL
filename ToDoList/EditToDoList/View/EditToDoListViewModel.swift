//
//  EditToDoListViewModel.swift
//  ToDoList
//
//  Created by Joseph William Santoso on 29/07/23.
//

import Foundation
import CoreData

class EditToDoListViewModel:ObservableObject{
    
    @Published var tasks: [TaskItem] = []
    
    let dataService = PersistenceController.shared
    
    @Published var selectedTaskItem: TaskItem?
    @Published var tkName: String = ""
    @Published var tkDesc: String = ""
    @Published var tkDue: Date = Date()
    
    
    init() {
        getAllTasks()
    }
    
    func getAllTasks() {
        tasks = dataService.read()
    }
    
    func createTask() {
        dataService.create(taskName: tkName, taskDesc: tkDesc, taskDue: tkDue)
        getAllTasks()
    }
    
    func updateTask(taskName: String? = nil, taskDesc: String? = nil, taskDue: Date? = nil) {
        if let task = selectedTaskItem {
            dataService.update(entity: task, taskName: tkName, taskDesc: tkDesc, taskDue: tkDue)
            getAllTasks()
        }
    }
    


    
    func deleteTask(task: TaskItem) {
        dataService.delete(task)
        getAllTasks()
    }
    
    func clearStates() {
        tkName = ""
        tkDesc = ""
        tkDue = Date()
    }
    
}

