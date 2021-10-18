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
    //デバイスのスクリーンの幅
    let screenWidth = UIScreen.main.bounds.width
    //デバイスのスクリーンの高さ
    let screenHeight = UIScreen.main.bounds.height
    //設定可能な時間単位の数値
    var hours = [Int](0..<24)
    //設定可能な分単位の数値
    var minutes = [Int](0..<60)
    
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
                            Spacer()
                            //時間単位のPicker
                            Picker(selection: self.$timeManager.hourSelection, label: Text("hour")) {
                                ForEach(0 ..< self.hours.count) { index in
                                    Text("\(self.hours[index])")
                                        .tag(index)
                                }
                            }
                            //上下に回転するホイールスタイルを指定
                            .pickerStyle(WheelPickerStyle())
                            //ピッカーの幅をスクリーンサイズ x 0.1、高さをスクリーンサイズ x 0.4で指定
                            .frame(width: self.screenWidth * 0.1, height: self.screenWidth * 0.4)
                            //上のframeでクリップし、フレームからはみ出す部分は非表示にする
                            .clipped()
                            //時間単位を表すテキスト
                            Text("時間")
                                .font(.headline)
                            
                            //分単位のPicker
                            Picker(selection: self.$timeManager.minSelection, label: Text("minute")) {
                                ForEach(0 ..< self.minutes.count) { index in
                                    Text("\(self.minutes[index])")
                                        .tag(index)
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                            .frame(width: self.screenWidth * 0.1, height: self.screenWidth * 0.4)
                            .clipped()
                            //分単位を表すテキスト
                            Text("分")
                                .font(.headline)
                            Spacer()
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
