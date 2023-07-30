//
//  ToDoListView.swift
//  ToDoList
//
//  Created by Joseph William Santoso on 29/07/23.
//

import SwiftUI

struct ToDoListView: View {
    
    @ObservedObject var vm = ToDoListViewModel()
    
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
                                Text(vm.formatDayOfWeek(date: vm.date))
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.black)
                                Text(vm.formatDate(date: vm.date))
                                    .font(.headline)
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color.black)
                                    .padding(.bottom)
                            }
                            
                            
                            HStack{
                                NavigationLink(destination: EditToDoListView()) {
                                    Image(systemName: "plus.circle.fill")
                                }
                                .padding()
                                .foregroundColor(.white)
                                .background(Color.blue)
                                .cornerRadius(8)
                                
                                Button(action: {
                                    // Code to handle the "Edit" button action
                                    print("Edit button tapped!")
                                }) {
                                    HStack {
                                        Image(systemName: "pencil.circle.fill")
                                    }
                                    .padding()
                                    .foregroundColor(.white)
                                    .background(Color.green)
                                    .cornerRadius(8)
                                }
                            }
                            
                            Divider()
                                .padding(0.5)
                                .background(.black)
                        }
                        .frame(width: geometry.size.width * 1)
                        
                        
                        VStack{
                            ScrollView{
                                
                            }
                        }
                        .frame(width: geometry.size.width * 1)
                    }
                }
            }
        }
        
    }
}

struct ToDoListView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoListView()
    }
}
