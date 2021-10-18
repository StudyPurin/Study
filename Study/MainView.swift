//
//  MainView.swift
//  Study
//
//  Created by cmStudent on 2021/10/12.
//

import SwiftUI
import AudioToolbox

struct MainView: View {
    @ObservedObject var timeManager: TimeManager = .shared
    
    var body: some View {
        NavigationView{
            ZStack {
                
                if timeManager.isProgressBarOn {
                    ProgressBarView()
                }
                
                if timeManager.timerStatus == .stopped {
                    PickerView()
                } else {
                    TimerMainView()
                }
                
                VStack {
                    Spacer()
                    //ButtonsViewとSettingButtonViewをレイヤー状に重ねる
                    ZStack {
                        ButtonsView()
                            .padding(.bottom)
                    }
                }
            }
            //指定した時間（1秒）ごとに発動するtimerをトリガーにしてクロージャ内のコードを実行
            .onReceive(timeManager.timer) { _ in
                //タイマーステータスが.running以外の場合何も実行しない
                guard self.timeManager.timerStatus == .running else { return }
                //残り時間が0より大きい場合
                if self.timeManager.duration > 0 {
                    //残り時間から -0.05 する
                    self.timeManager.duration -= 0.05
                    
                    
                    //残り時間が0以下の場合
                } else {
                    //タイマーステータスを.stoppedに変更する
                    self.timeManager.timerStatus = .stopped
                    
               
                    //アラーム音を鳴らす
                    AudioServicesPlayAlertSoundWithCompletion(self.timeManager.soundID, nil)
                    //バイブレーションを作動させる
                    AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(kSystemSoundID_Vibrate)) {}
                }
            }
            .navigationBarTitle("タイマー")
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
            MainView()
    }
}
