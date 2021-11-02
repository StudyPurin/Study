//
//  SettingView.swift
//  Study
//
//  Created by cmStudent on 2021/10/13.
//

import SwiftUI

struct SettingView: View {
    //モーダルを利用するためのプロパティ
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var timeManager: TimeManager = .shared
    @State private var showingAlert = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("記録")) {
                    NavigationLink(destination: RecordView()) {
                        HStack {
                            Text("削除する科目")
                        }
                    }
                }
                Section(header: Text("タイマー")) {
                    Toggle(isOn: $timeManager.isAlarmOn) {
                        Text("音")
                    }
                    Toggle(isOn: $timeManager.isVibrationOn) {
                        Text("バイブレーション")
                    }
                    //サウンド選択画面へ画面遷移
                    NavigationLink(destination: SoundListView()) {
                        HStack {
                            //設定項目名
                            Text("アラーム音")
                            Spacer()
                            //現在選択中のアラーム音
                            Text("\(timeManager.soundName)")
                        }
                    }
                    Toggle(isOn: $timeManager.isProgressBarOn) {
                        Text("円の表示")
                    }
                }
                Section(header: Text("")) {
                    HStack{
                        Spacer()
                        Button("総勉強時間をリセット") {
                            self.showingAlert = true
                        }
                        .foregroundColor(.red)
                        .alert(isPresented: $showingAlert) {
                            Alert(title: Text("警告"), message: Text("データが削除されますがよろしいですか？"), primaryButton: .cancel(Text("キャンセル")), secondaryButton: .destructive(Text("削除"), action: {
                                self.timeManager.studyTime = 0
                                
                                self.timeManager.dateStudy.removeAll()
                                self.timeManager.subjectStudy.removeAll()
                                self.timeManager.hourStudy.removeAll()
                                self.timeManager.minStudy.removeAll()
                                self.timeManager.memoStudy.removeAll()
                                UserDefaults.standard.setValue(self.timeManager.dateStudy, forKey: "date")
                                UserDefaults.standard.setValue(self.timeManager.subjectStudy, forKey: "subject")
                                UserDefaults.standard.setValue(self.timeManager.hourStudy, forKey: "hour")
                                UserDefaults.standard.setValue(self.timeManager.minStudy, forKey: "min")
                                UserDefaults.standard.setValue(self.timeManager.memoStudy, forKey: "memo")
                                UserDefaults.standard.setValue(self.timeManager.studyTime, forKey: "study")
                                
                            })) // 破壊的変更用
                        }
                        Spacer()
                    }
                }
            }
            
            .navigationBarTitle("設定", displayMode: .automatic)
            .navigationViewStyle(DefaultNavigationViewStyle())
        }
        .onAppear {
            if case self.timeManager.addText = UserDefaults.standard.array(forKey: "TODO") as? [String] {
                self.timeManager.addText = timeManager.addText
            }
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}

