//
//  SubjectView.swift
//  Study
//
//  Created by cmStudent on 2021/10/15.
//

import SwiftUI

struct SubjectView: View, InputViewDelegate {
    @ObservedObject var timeManager: TimeManager = .shared
    @State var todos: [String] = []
    @State var pickerSelection = 0
    @State private var selectionDate = Date()
    
    var body: some View {
        NavigationView{
            ZStack() {
                Form {
                    Section(header: Text("科目")) {
                        HStack{
                            Picker(selection: $pickerSelection, label: Text("科目名")) {
                                ForEach(0..<self.todos.count, id: \.self) { index in
                                    if index == 0 {
                                        Text("なし")
                                    } else {
                                        Text(self.todos[index])
                                    }
                                    
                                }
                            }
                        }
                        HStack{
                            NavigationLink(destination: InputView(delegate: self, text: "")) {
                                Text("  科目の追加")
                                    .multilineTextAlignment(.center)
                            }
                        }
                        HStack{
                            NavigationLink(destination: SubjectColorView()) {
                                Text("色")
                            }
                        }
                    }
                    Section(header: Text("時間")) {
                        HStack {
                            DatePicker("", selection: $selectionDate)
                        }
                    }
                }
            }
            .onAppear {
                if let todos = UserDefaults.standard.array(forKey: "TODO") as? [String] {
                    self.todos = todos
                }
            }
            .navigationTitle("TODO")
        }
        
    }
    
    func delete(at offsets: IndexSet) {
        todos.remove(atOffsets: offsets)
        print(todos)
        UserDefaults.standard.setValue(todos, forKey: "TODO")
    }
    
    func addTodo(text: String) {
        todos.append(text)
        UserDefaults.standard.setValue(todos, forKey: "TODO")
    }
}

protocol InputViewDelegate {
    func addTodo(text: String)
}

struct InputView: View {
    @Environment(\.presentationMode) var presentation
    let delegate: InputViewDelegate
    @State var text: String
    var body: some View {
        VStack {
            TextField("ここに入力してください", text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Button("Add") {
                delegate.addTodo(text: text)
                presentation.wrappedValue.dismiss()
            }
        }
        .padding()
    }
}

struct SubjectView_Previews: PreviewProvider {
    static var previews: some View {
        SubjectView()
    }
}
