//
//  SettingView.swift
//  Study
//
//  Created by cmStudent on 2021/10/11.
//

import SwiftUI

struct SettingView: View {
    // 永続化する秒数設定（初期値は10）
    @AppStorage("timer_value") var timerValue = 0
    @AppStorage("timer_value2") var timerValue2 = 0
    @AppStorage("timer_value3") var timerValue3 = 0
    
    var body: some View {
        // 奥から手前方向にレイアウト
        ZStack {
            // 背景色表示
            Color("bakcgroundSetting")
                // セーフエリアを超えて画面全体に配置します
                .edgesIgnoringSafeArea(.all)
            
            // 垂直にレイアウト（縦方向にレイアウト）
            VStack {
                // スペースを空ける
                Spacer()
                
                // テキストを表示する
                Text(String(format: "%02d:%02d:%02d", timerValue3 , timerValue2 , timerValue))
                    .font(.largeTitle)
                // スペースを空ける
                Spacer()
                
                // Pickerを表示
                GeometryReader { geometry in
                    HStack {
                        Picker(selection: $timerValue3, label: Text("選択")) {
                            ForEach(0 ..< 24) {
                                Text("\($0)")
                            }
                        }.pickerStyle(WheelPickerStyle())
                        .frame(width: geometry.size.width / 3, height: geometry.size.height)
                        .clipped()
                        Picker(selection: $timerValue2, label: Text("選択")) {
                            ForEach(0 ..< 60) {
                                Text("\($0)")
                            }
                        }.pickerStyle(WheelPickerStyle())
                        .frame(width: geometry.size.width / 3, height: geometry.size.height)
                        .clipped()
                        
                        Picker(selection: $timerValue, label: EmptyView()) {
                            ForEach(0 ..< 60) {
                                Text("\($0)")
                            }
                        }
                        .frame(width: geometry.size.width / 3, height: geometry.size.height)
                        .clipped()
                        
                    }
                } // VStack ここまで
            }
        } // ZStack ここまで
    } // Body ここまで
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
