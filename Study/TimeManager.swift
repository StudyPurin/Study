//
//  TimeManager.swift
//  Study
//
//  Created by cmStudent on 2021/10/12.
//

import SwiftUI
import AudioToolbox

class TimeManager: ObservableObject {
    private init() { }
    
    static let shared = TimeManager()
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
    //タイマーのステータス
    @Published var timerStatus: TimerStatus = .stopped
    //AudioToolboxに格納された音源を利用するためのデータ型でデフォルトのサウンドIDを格納
    @Published var soundID: SystemSoundID = 1151
    //soundIDプロパティの値に対応するサウンド名を格納
    @Published var soundName: String = "Beat"
    
    @Published var addText: [String] = []
    //アラーム音オン/オフの設定
    @Published var isAlarmOn: Bool = true
    //バイブレーションオン/オフの設定
    @Published var isVibrationOn: Bool = true
    //プログレスバー表示オン/オフの設定
    @Published var isProgressBarOn: Bool = true
    //エフェクトアニメーション表示オン/オフの設定
    @Published var isEffectAnimationOn: Bool = true
    //設定画面の表示/非表示
    @Published var isSetting: Bool = false
    //1秒ごとに発動するTimerクラスのpublishメソッド
    var timer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()
    
    //Pickerで取得した値からカウントダウン残り時間とカウントダウン開始前の最大時間を計算しその値によって時間表示形式も指定する
    func setTimer() {
        //残り時間をPickerから取得した時間・分・秒の値をすべて秒換算して合計して求める
        duration = Double(hourSelection * 3600 + minSelection * 60 + secSelection)
        //Pickerで時間を設定した時点=カウントダウン開始前のため、残り時間=最大時間とする
        maxValue = duration

    }
    
    //カウントダウン中の残り時間を表示するためのメソッド
    func displayTimer() -> String {
        //残り時間（時間単位）= 残り合計時間（秒）/3600秒
        let hr = Int(duration) / 3600
        //残り時間（分単位）= 残り合計時間（秒）/ 3600秒 で割った余り / 60秒
        let min = Int(duration) % 3600 / 60
        //残り時間（秒単位）= 残り合計時間（秒）/ 3600秒 で割った余り / 60秒 で割った余り
        let sec = Int(duration) % 3600 % 60
        
        return String(format: "%02d:%02d:%02d", hr, min, sec)
    }
    
    //スタートボタンをタップしたときに発動するメソッド
    func start() {
        //タイマーステータスを.runningにする
        timerStatus = .running
    }
    
    //一時停止ボタンをタップしたときに発動するメソッド
    func pause() {
        //タイマーステータスを.pauseにする
        timerStatus = .pause
    }
    
    //リセットボタンをタップしたときに発動するメソッド
    func reset() {
        //タイマーステータスを.stoppedにする
        timerStatus = .stopped
        //残り時間がまだ0でなくても強制的に0にする
        duration = 0
    }
}
