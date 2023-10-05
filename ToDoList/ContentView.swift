//
//  ContentView.swift
//  ToDoList
//
//  Created by Thomas Whelan on 04/10/2023.
//

import SwiftUI

struct ContentView: View {
    @State var todoTextField: String = ""
    @State var todoDataArray: [(String, Bool)] = []

    var body: some View {
        VStack {
            Image("todo")
                .resizable()
                .frame(width: 300, height: 200)
            Text("To Do:")
                .font(.largeTitle.bold())

            HStack {
                TextField("Text here...", text: $todoTextField)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .foregroundColor(.blue)
                    .font(.headline)

                Button(action: {
                    if validInput() {
                        saveTodo()
                    }
                }) {
                    Text("Add to list")
                        .fontWeight(.heavy)
                        .background(validInput() ? Color(.systemBlue) : Color(.lightGray))
                        .foregroundColor(.white)
                        .cornerRadius(1)
                }
                .disabled(!validInput())

                Button(action: {
                    todoDataArray.removeAll() // Clear the todoDataArray
                }) {
                    Text("Clear All")
                        .fontWeight(.heavy)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(1)
                }
            }
            .padding()

            ForEach(todoDataArray.indices, id: \.self) { index in
                Toggle(isOn: Binding(
                    get: { self.todoDataArray[index].1 },
                    set: { newValue in self.todoDataArray[index].1 = newValue }
                )) {
                    Text(self.todoDataArray[index].0)
                        .font(.headline.bold())
                }
                .toggleStyle(SwitchToggleStyle(tint: Color(.systemBlue)))
            }
        }
        .padding()
    }

    func validInput() -> Bool {
        if todoTextField.count >= 3 {
            return true
        }
        return false
    }

    func saveTodo() {
        todoDataArray.append((todoTextField, false))
        todoTextField = ""
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
