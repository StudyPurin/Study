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
            }
            .navigationBarTitle("設定", displayMode: .automatic)
            .navigationViewStyle(DefaultNavigationViewStyle())
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}

