//
//  EditToDoListView.swift
//  ToDoList
//
//  Created by Joseph William Santoso on 29/07/23.
//

import SwiftUI

struct EditToDoListView: View {
    
    @ObservedObject var vm = EditToDoListViewModel()
    
    var body: some View {
        GeometryReader{geometry in
            ZStack{
                VStack{
                    Group{
                        Text("Your Task :")
                            .fontWeight(.bold)
                            .padding(.top, 30.0)
                        TextField("Your Task", text: $vm.taskName)
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
                        TextField("Description", text: $vm.taskDesc)
                            .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.1)
                            .padding([.leading, .trailing],0)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.black, lineWidth: 1)
                            )
                            .padding(.bottom, 30.0)
                        
                        Text("Task Due :")
                            .fontWeight(.bold)
                        Toggle("Schedule Time", isOn: $vm.scheduleTime)
                            .frame(width: geometry.size.width * 0.8)
                        DatePicker("Due", selection: $vm.taskDue, displayedComponents: vm.displayComps())
                            .frame(width: geometry.size.width * 0.8)
                        
                        
                        Button(action: {
                            // Code to handle the "Save" button action
                            print("Save button tapped!")
                        }) {
                            HStack {
                                Text("Save")
                                    .fontWeight(.bold)
                            }
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.green)
                            .cornerRadius(8)
                            
                        }
                        .padding(.top, 40.0)

                    }
                    Spacer()
                }
                .frame(width: geometry.size.width * 1)
            }
        }
    }
}

struct EditToDoListView_Previews: PreviewProvider {
    static var previews: some View {
        EditToDoListView()
    }
}
