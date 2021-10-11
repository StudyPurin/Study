//
//  TimerView.swift
//  Study
//
//  Created by cmStudent on 2021/10/11.
//

import SwiftUI

struct TimerView: View {
    // タイマーの変数を作成
    @State var timerHandler: Timer?
    // ストップウォッチの変数を作成
    @State var stopWatchHandler: Timer?
    // カウント（経過時間の変数を作成）
    @State var stopWatchCount:Float = 0.0
    @State var timerCount = 0
    // 永続化する秒数設定（初期値は10）
    @AppStorage("timer_value") var timerValue = 0
    // 永続化する分数設定（初期値は1）
    @AppStorage("timer_value2") var timerValue2 = 0
    @AppStorage("timer_value3") var timerValue3 = 0
    // 画面切り替えボタン
    @State var gamen = 0
    // ボタンを押せなくするための関数
    @State var botan = 0
    @State var minutes = 0
    @State var second = 0
    @State var milliSecond = 0
    @State var showAlert = false
    var body: some View {
        
        
        if gamen == 0 {
            NavigationView{
                // 奥から手前方向にレイアウト
                ZStack {
                    VStack(spacing: 30.0) {
                        Text(String(format: "%02d:%02d.%02d", minutes, second, milliSecond))
                            .font(.largeTitle)
                        // 水平に（横方向にレイアウト）
                        HStack {
                            // スタートボタン
                            if botan == 0 {
                                Button(action: {
                                    startStopWatch()
                                    botan = 1
                                    
                                }) {
                                    // テキストを表示する
                                    Text("スタート")
                                        // 文字サイズを指定
                                        .font(.title)
                                        // 文字色を白に指定
                                        .foregroundColor(Color.white)
                                        // 幅高さを140に指定
                                        .frame(width: 140, height: 140)
                                        //　背景を設定
                                        .background(Color("startColor"))
                                        // 円形に切り抜く
                                        .clipShape(Circle())
                                } // スタートボタン ここまで
                            }else {
                                Text("スタート")
                                    // 文字サイズを指定
                                    .font(.title)
                                    // 文字色を白に指定
                                    .foregroundColor(Color.white)
                                    // 幅高さを140に指定
                                    .frame(width: 140, height: 140)
                                    //　背景を設定
                                    .background(Color("stopColor"))
                                    // 円形に切り抜く
                                    .clipShape(Circle())
                            }
                            if botan == 0 {
                                Button(action: {
                                    // ボタンをタップした時のアクション
                                    //　これらの関数の値をリセットするために0を代入する
                                    minutes = 0
                                    second = 0
                                    milliSecond = 0
                                    stopWatchCount = 0.0
                                }) {
                                    // テキストを表示する
                                    Text("リセット")
                                        // 文字サイズを指定
                                        .font(.title)
                                        // 文字色を白に指定
                                        .foregroundColor(Color.white)
                                        // 幅高さを140に指定
                                        .frame(width: 140, height: 140)
                                        //　背景を設定
                                        .background(Color("startColor"))
                                        // 円形に切り抜く
                                        .clipShape(Circle())
                                } // リセットボタン ここまで
                            } else {
                                // ストップボタン
                                Button(action: {
                                    // ボタンをタップした時のアクション
                                    // timerHandlerをアンラップしてunwrapedTimerHandlerに代入
                                    if let unwrapedStopWatchHandler = stopWatchHandler {
                                        // もしタイマーが、実行中だったら停止
                                        if unwrapedStopWatchHandler.isValid == true {
                                            // タイマー停止
                                            unwrapedStopWatchHandler.invalidate()
                                        }
                                    }
                                    botan = 0
                                }) {
                                    // テキストを表示する
                                    Text("ストップ")
                                        // 文字サイズを指定
                                        .font(.title)
                                        // 文字色を白に指定
                                        .foregroundColor(Color.white)
                                        // 幅高さを140に指定
                                        .frame(width: 140, height: 140)
                                        // 背景を設定
                                        .background(Color("startColor"))
                                        // 円形に切り抜く
                                        .clipShape(Circle())
                                } // ストップボタン　ここまで
                            }
                        } // HStack ここまで
                        //　HStack
                        HStack {
                            // タイマー切り替えボタン
                            Button(action: {gamen = 1}) {
                                Image(systemName: "timer")
                                    .resizable()
                                    .frame(width: 70,height: 70)
                            }
                            // ストップウォッチ切り替えボタン
                            Button(action: {gamen = 0}) {
                                Image(systemName: "stopwatch")
                                    .resizable()
                                    .frame(width: 70,height: 70)
                            }
                        } // HStack ここまで
                    } // VStack　ここまで
                } // ZStack ここまで
                // 画面が表示されるときに実行される
                .onAppear {
                    // カウント（経過時間）の半数を初期化
                    timerCount = 0
                } // .onApper ここまで
                // ナビゲーションバーにボタンを追加
                .navigationBarItems(trailing:
                                        // ナビゲーション遷移
                                        
                                        NavigationLink(destination: SettingView()) {
                                            if gamen == 1 {
                                                // テキストを表示
                                                Text("秒数設定")
                                            }
                                        } // NavigationLink ここま
                ) // .navigationBarItems ここまで
                .navigationTitle("ストップウォッチ")
            } // NavigationView ここまで
        } else {
            NavigationView{
                // 奥から手前方向にレイアウト
                ZStack {
                    VStack(spacing: 30.0) {
                        // テキストを表示する
                        Text(String(format: "%02d:%02d:%02d" , ((3600 * timerValue3) + (60 * timerValue2) + (timerValue - Int(self.timerCount))) / 3600 , ((3600 * timerValue3) + (60 * timerValue2) + (timerValue - Int(self.timerCount))) / 60 % 60 , ((3600 * timerValue3) + (60 * timerValue2) + (timerValue - Int(self.timerCount))) % 60))
                            // 文字サイズを指定
                            .font(.largeTitle)
                        
                        // 水平にレイアウト（横方向にレイアウト）
                        HStack {
                            // スタートボタン
                            Button(action: {
                                // ボタンをタップした時のアクション
                                // タイマーカウントダウン開始する関数を呼び出す
                                startTimer1()
                            }) {
                                // テキストを表示する
                                Text("スタート")
                                    // 文字サイズを指定
                                    .font(.title)
                                    // 文字色を白に指定
                                    .foregroundColor(Color.white)
                                    // 幅高さを140に指定
                                    .frame(width: 140, height: 140)
                                    //　背景を設定
                                    .background(Color("startColor"))
                                    // 円形に切り抜く
                                    .clipShape(Circle())
                            } // スタートボタン ここまで
                            // ストップボタン
                            Button(action: {
                                // ボタンをタップした時のアクション
                                // timerHandlerをアンラップしてunwrapedTimerHandlerに代入
                                if let unwrapedTimerHandler = timerHandler {
                                    // もしタイマーが、実行中だったら停止
                                    if unwrapedTimerHandler.isValid == true {
                                        // タイマー停止
                                        unwrapedTimerHandler.invalidate()
                                    }
                                }
                            }) {
                                // テキストを表示する
                                Text("ストップ")
                                    // 文字サイズを指定
                                    .font(.title)
                                    // 文字色を白に指定
                                    .foregroundColor(Color.white)
                                    // 幅高さを140に指定
                                    .frame(width: 140, height: 140)
                                    // 背景を設定
                                    .background(Color("startColor"))
                                    // 円形に切り抜く
                                    .clipShape(Circle())
                            } // ストップボタン　ここまで
                        } // HStack ここまで
                        HStack {
                            // タイマー切り替えボタン
                            Button(action: {gamen = 1}) {
                                Image(systemName: "timer")
                                    .resizable()
                                    .frame(width: 70,height: 70)
                            }
                            // ストップウォッチ切り替えボタン
                            Button(action: {gamen = 0}) {
                                Image(systemName: "stopwatch")
                                    .resizable()
                                    .frame(width: 70,height: 70)
                            }
                        } // HStack ここまで
                    } // VStack　ここまで
                } // ZStack ここまで
                // 画面が表示されるときに実行される
                .onAppear {
                    // カウント（経過時間）の半数を初期化
                    timerCount = 0
                } // .onApper ここまで
                // ナビゲーションバーにボタンを追加
                .navigationBarItems(trailing:
                                        // ナビゲーション遷移
                                        
                                        NavigationLink(destination: SettingView()) {
                                            if gamen == 1 {
                                                // テキストを表示
                                                Text("秒数設定")
                                            }
                                        } // NavigationLink ここま
                ) // .navigationBarItems ここまで
                .alert(isPresented: $showAlert) {
                    // アラート訪寺するためのレイアウトを記述する
                    // アラートを表示する
                    Alert(title: Text("終了"),
                          message: Text("タイマー終了時間です"),
                          dismissButton: .default(Text("OK")))
                } // alert　ここまで
                .navigationTitle("タイマー")
            } // NavigationView ここまで
        }
    } // body ここまで
    
    // 1秒毎に実行されてカウントダウンする
    func countDownTimer() {
        if gamen == 1 {
            
            // 残り時間が0以下のとき、タイマーを止める
            if timerValue - timerCount % 60 <= 0 && timerValue2 - timerCount / 60 <= 0 && timerValue3 / 1 <= 0 {
                // タイマー停止
                timerHandler?.invalidate()
                
                showAlert = true
            }
        }
    } // countDownTimer() ここまで
    
    // ストップウォッチを開始する関数
    func startStopWatch() {
        // ストップウォッチをスタート
        stopWatchHandler = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
            self.stopWatchCount += 0.01
            // ミリ秒は小数点第一位、第二位なので100をかけて100で割った余り
            milliSecond = (Int(self.stopWatchCount * 100) % 100)
            // 秒は1・2桁なので60で割った余り
            second = (Int(self.stopWatchCount) % 60)
            // 分は経過秒を60で割った商
            minutes = (Int(self.stopWatchCount) / 60)
        }
    } // startStopWatch ここまで
    // タイマーを開始する関数
    func startTimer1() {
        // timerHandlerをアンラップしてunwrapedTimerHandlerに代入
        if let unwrapedTimerHandler = timerHandler {
            // もしタイマーが、実行中だったらスタートしない
            if unwrapedTimerHandler.isValid == true {
                // 何も処理しない
                return
            }
        }
        
        // 残り時間が0以下のとき、count（経過時間）を０に初期化する
        if timerValue - timerCount <= 0 {
            // count(経過時間）を0に初期化する
            timerCount = 0
        }
        
        // タイマーをスタート
        timerHandler = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
            self.timerCount += 1
            countDownTimer()
        }
    } // startTimer1 ここまで
} // contentView ここまで

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
