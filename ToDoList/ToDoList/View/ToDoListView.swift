//
//  ToDoListView.swift
//  ToDoList
//
//  Created by Joseph William Santoso on 29/07/23.
//

import SwiftUI
import CoreData

struct ToDoListView: View {
    
    @ObservedObject var vm2: ToDoListViewModel // Pass the shared instance
    @ObservedObject var vm = EditToDoListViewModel()
    
    init() {
        let dataService = PersistenceController.shared
        vm2 = ToDoListViewModel(dataService: dataService)
    }
    
    var body: some View {
        NavigationView{
            GeometryReader{ geometry in
                ZStack{
                    VStack{
                        VStack (alignment: .center){
                            
                            Group{
                                Text("To Do")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.black)
                                    .multilineTextAlignment(.center)
                                    .padding(10)
                                Text(vm2.formatDayOfWeek(date: vm2.date))
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.black)
                                Text(vm2.formatDate(date: vm2.date))
                                    .font(.headline)
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color.black)
                                    .padding(.bottom)
                            }
                            
                            
                            HStack{
                                NavigationLink(destination: EditToDoListView(viewMode: .add)) {
                                    Image(systemName: "plus.circle.fill")
                                }
                                .padding()
                                .foregroundColor(.white)
                                .background(Color.blue)
                                .cornerRadius(8)
                            }
                            
                            Divider()
                                .padding(0.5)
                                .background(.black)
                        }
                        .frame(width: geometry.size.width * 1)
                        
                        
                        VStack {
                            if vm.tasks.count == 0 {
                                Text("No task created yet. Press the Add button to create one.")
                                    .multilineTextAlignment(.center)
                                    .bold()
                                    .foregroundColor(.secondary)
                            } else {
                                List {
                                    ForEach(vm.tasks) { tsk in
                                        // Note Row
                                        NavigationLink(destination: EditToDoListView(selectedTask: tsk, viewMode: .edit)) {
                                            HStack {
                                                VStack(alignment: .leading) {
                                                    // title
                                                    Text(tsk.taskName ?? "")
                                                        .font(.title3)
                                                        .lineLimit(1)
                                                        .bold()
                                                    
                                                    // body preview
                                                    Text((tsk.taskDesc ?? ""))
                                                }
                                                Spacer()
                                                let dateFormatter: DateFormatter = {
                                                    let formatter = DateFormatter()
                                                    formatter.dateStyle = .medium // Customize the date style according to your preference
                                                    formatter.timeStyle = .short // Customize the time style according to your preference
                                                    return formatter
                                                }()
                                                
                                                // task date
                                                Text(dateFormatter.string(from: tsk.taskDue ?? Date()))
                                                    .font(.caption)
                                                    .lineLimit(1)
                                            }
                                            .swipeActions {
                                                Button(role: .destructive) {
                                                    vm.deleteTask(task: tsk)
                                                } label: {
                                                    Label("Delete", systemImage: "trash")
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        .onAppear {
                            vm.getAllTasks()
                        }
                        
                    }
                }
            }
            .refreshable {
                // Perform the refresh action here
                vm2.getAllTasks()
            }
        }
        
    }
}

struct ToDoListView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoListView()
    }
}
