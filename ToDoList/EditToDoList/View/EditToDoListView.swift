//
//  EditToDoListView.swift
//  ToDoList
//
//  Created by Joseph William Santoso on 29/07/23.
//

import SwiftUI

struct EditToDoListView: View {
    
    @ObservedObject var vm = EditToDoListViewModel()
    var selectedTask: TaskItem?
    var viewMode: ViewMode
    
    var body: some View {
        GeometryReader{geometry in
            ZStack{
                VStack{
                    Group{
                        Text("Your Task :")
                            .fontWeight(.bold)
                            .padding(.top, 30.0)
                        TextField("Your Task", text: $vm.tkName)
                            .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.05)
                            .padding([.leading, .trailing],0)
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.black, lineWidth: 1)
                            )
                            .padding(.bottom, 30.0)
                        
                        Text("Description :")
                            .fontWeight(.bold)
                        TextField("Description", text: $vm.tkDesc)
                            .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.1)
                            .padding([.leading, .trailing],0)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.black, lineWidth: 1)
                            )
                            .padding(.bottom, 30.0)
                        
                        Text("Task Due :")
                            .fontWeight(.bold)
                        DatePicker("Due", selection: $vm.tkDue)
                            .frame(width: geometry.size.width * 0.8)
                        
                        
                        switch viewMode {
                        case .add:
                            // Code to handle the "Save" button action
                            ActionButton(label: "Save") {
                                vm.createTask()
                                vm.clearStates()
                            }
                            .padding(.top, 40.0)
                            
                        case .edit:
                            // Code to handle the "Update" button action
                            ActionButton(label: "Update") {
                                vm.updateTask()
                            }
                            .padding(.top, 40.0)
                        }
//
                    }
                    Spacer()
                }
                .onAppear {
                    if let selectedTask = selectedTask {
                        vm.selectedTaskItem = selectedTask
                        vm.tkName = selectedTask.taskName ?? ""
                        vm.tkDesc = selectedTask.taskDesc ?? ""
                        vm.tkDue = selectedTask.taskDue ?? Date()
                    }
                }
                .frame(width: geometry.size.width * 1)
            }
        }
    }
}


struct EditToDoListView_Previews: PreviewProvider {
    static var previews: some View {
        EditToDoListView(viewMode: .edit)
    }
}

