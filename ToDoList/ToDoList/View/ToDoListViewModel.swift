//
//  ToDoListViewModel.swift
//  ToDoList
//
//  Created by Joseph William Santoso on 29/07/23.
//

import Foundation
import CoreData

class ToDoListViewModel: ObservableObject{
    
    @Published var date:Date = Date()
    @Published var tasks: [TaskItem] = []
    
    let dataService: PersistenceController // Use the same instance of PersistenceController
    
    init(dataService: PersistenceController) {
        self.dataService = dataService
        getAllTasks()
    }
    
    func getAllTasks() {
        tasks = dataService.read()
    }
    
    func formatDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        return dateFormatter.string(from: date)
    }
    
    func formatDayOfWeek(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: date)
    }
    
}
