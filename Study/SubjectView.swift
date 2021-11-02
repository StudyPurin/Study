//
//  SubjectView.swift
//  Study
//
//  Created by cmStudent on 2021/10/15.
//

import SwiftUI

struct SubjectView: View, InputViewDelegate {
    @ObservedObject var timeManager: TimeManager = .shared
    // フォームの場所
    @State var pickerSelection = 0
    @State private var editor = ""
    @State var hr = 0
    @State var min = 0
    //デバイスのスクリーンの幅
    let screenWidth = UIScreen.main.bounds.width
    //デバイスのスクリーンの高さ
    let screenHeight = UIScreen.main.bounds.height
    //設定可能な時間単位の数値
    var hours = [Int](0..<24)
    //設定可能な分単位の数値
    var minutes = [Int](0..<60)
    //アラート
    @State private var showingAlert = false
    
    var body: some View {
        NavigationView{
            ZStack {
                Form {
                    Section(header: Text("科目")) {
                        HStack{
                            Picker(selection: $pickerSelection, label: Text("科目名")) {
                                ForEach(0..<self.timeManager.addText.count, id: \.self) { index in
                                    Text(self.timeManager.addText[index])
                                }
                            }
                        }
                        HStack{
                            NavigationLink(destination: InputView(delegate: self, text: "")) {
                                Text("  科目の追加")
                                    .multilineTextAlignment(.center)
                            }
                        }
                    }
                    Section(header: Text("時間")) {
                        DatePicker("日時を選択", selection: $timeManager.selectionDate, displayedComponents: .date)
                        
                        HStack {
                            Spacer()
                            //時間単位のPicker
                            Picker(selection: self.$timeManager.hourSelection2, label: Text("hour")) {
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
                            .compositingGroup()
                            //時間単位を表すテキスト
                            Text("時間")
                                .font(.headline)
                            
                            //分単位のPicker
                            Picker(selection: self.$timeManager.minSelection2, label: Text("minute")) {
                                ForEach(0 ..< self.minutes.count) { index in
                                    Text("\(self.minutes[index])")
                                        .tag(index)
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                            .frame(width: self.screenWidth * 0.1, height: self.screenWidth * 0.4)
                            .clipped()
                            .compositingGroup()
                            //分単位を表すテキスト
                            Text("分")
                                .font(.headline)
                            Spacer()
                        }
                    }.edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            UIApplication.shared.closeKeyboard()
                        }
                    Section(header: Text("メモ（勉強した内容・ページ数など）")) {
                        TextEditor(text: $editor)
                            .frame(width:  UIScreen.main.bounds.width * 0.8, height: 200, alignment: .center)
                            .border(Color.gray, width: 1)
                    }.edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            UIApplication.shared.closeKeyboard()
                        }
                    Section(header: Text("")) {
                        HStack{
                            Spacer()
                            if self.timeManager.addText.count == 0 {
                                Button("保存する") {
                                    self.showingAlert = true
                                }
                                .alert(isPresented: $showingAlert) {
                                    Alert(title: Text("科目が設定されていません"))
                                }
                            } else {
                                Button("保存する") {
                                    self.showingAlert = true
                                }
                                .alert(isPresented: $showingAlert) {
                                    Alert(title: Text(""),
                                          message: Text("保存しますか？"),
                                          primaryButton: .default(Text("キャンセル")),
                                          secondaryButton: .default(Text("保存"), action: {
                                        self.timeManager.minSelection3 = self.timeManager.hourSelection2 * 3600 +  self.timeManager.minSelection2 * 60
                                        self.timeManager.studyTime += Double(self.timeManager.minSelection3)
                                        hr = Int(self.timeManager.minSelection3) / 3600
                                        min = Int(self.timeManager.minSelection3) % 3600 / 60
                                        self.timeManager.hourStudy.append(hr)
                                        self.timeManager.minStudy.append(min)
                                        self.timeManager.dateStudy.append(timeManager.selectionDate)
                                        self.timeManager.memoStudy.append(editor)
                                        self.timeManager.subjectStudy.append(self.timeManager.addText[pickerSelection])
                                        UserDefaults.standard.setValue(self.timeManager.dateStudy, forKey: "date")
                                        UserDefaults.standard.setValue(self.timeManager.subjectStudy, forKey: "subject")
                                        UserDefaults.standard.setValue(self.timeManager.hourStudy, forKey: "hour")
                                        UserDefaults.standard.setValue(self.timeManager.minStudy, forKey: "min")
                                        UserDefaults.standard.setValue(self.timeManager.memoStudy, forKey: "memo")
                                        UserDefaults.standard.setValue(self.timeManager.studyTime, forKey: "study")
                                    }))    // 右ボタンの設定
                                }
                            }
                            Spacer()
                        }
                    }.edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            UIApplication.shared.closeKeyboard()
                        }
                }
            }
            .onAppear {
                if let todos = UserDefaults.standard.array(forKey: "TODO") as? [String] {
                    self.timeManager.addText = todos
                }
            }
            .navigationTitle("記録")
        }
        
    }
    
    
    
    func addTodo(text: String) {
        self.timeManager.addText.append(text)
        UserDefaults.standard.setValue(self.timeManager.addText, forKey: "TODO")
    }
    
    func dateFromString(string: String, format: String) -> Date {
        let formatter: DateFormatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.dateFormat = format
        return formatter.date(from: string)!
    }
    func stringFromDate(date: Date, format: String) -> String {
        let formatter: DateFormatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.dateFormat = format
        return formatter.string(from: date)
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
            Button("追加") {
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
            .environment(\.locale, Locale(identifier: "ja_JP"))
    }
}
