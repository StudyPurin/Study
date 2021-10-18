//
//  TimerManager.swift
//  Study
//
//  Created by cmStudent on 2021/10/12.
//

import SwiftUI

class TimerManager: ObservableObject {
    //Pickerで設定した"時間"を格納する変数
    @Published var hourSelection: Int = 0
    //Pickerで設定した"分"を格納する変数
    @Published var minSelection: Int = 0
    //Pickerで設定した"秒"を格納する変数
    @Published var secSelection: Int = 0
    //カウントダウン残り時間
    @Published var duration: Double = 0
    //カウントダウン開始前の最大時間
    @Published var maxValue: Double = 0
    
    
    //
    func setTimer() {
        duration = Double(hourSelection * 3600 + minSelection * 60 + secSelection)
        maxValue = duration
    }
}
