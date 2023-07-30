//
//  Button.swift
//  ToDoList
//
//  Created by Joseph William Santoso on 30/07/23.
//

import SwiftUI

struct ActionButton: View {
    
    var label: String = ""
    var action: () -> Void
    
    var body: some View {
        
        Button(action: action) {
            HStack {
                Text(label)
                    .fontWeight(.bold)
            }
            .padding()
            .foregroundColor(.white)
            .background(Color.green)
            .cornerRadius(8)
        }
    }
}


