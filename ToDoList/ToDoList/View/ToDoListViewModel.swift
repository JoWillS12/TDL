//
//  ToDoListViewModel.swift
//  ToDoList
//
//  Created by Joseph William Santoso on 29/07/23.
//

import Foundation

class ToDoListViewModel: ObservableObject{
    
    @Published var date:Date = Date()
    
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
