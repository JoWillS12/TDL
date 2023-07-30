//
//  EditToDoListViewModel.swift
//  ToDoList
//
//  Created by Joseph William Santoso on 29/07/23.
//

import Foundation
import SwiftUI

class EditToDoListViewModel:ObservableObject{
    
    @Published var taskName: String = ""
    @Published var taskDesc: String = ""
    @Published var taskDue: Date = Date()
    @Published var scheduleTime: Bool = false
    
    func displayComps() -> DatePickerComponents{
        return scheduleTime ? [.hourAndMinute, .date] : [.date]
    }
}
