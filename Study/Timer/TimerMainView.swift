//
//  TimerMainView.swift
//  Study
//
//  Created by cmStudent on 2021/10/12.
//

import SwiftUI

struct TimerMainView: View {
    @ObservedObject var timeManager: TimeManager = .shared
    
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    var body: some View {
        ZStack {
            //時間表示形式が時間、分、秒によって、タイマーの文字サイズを条件分岐させる
            //表示形式が"時間"の場合
           
                Text(self.timeManager.displayTimer())
                    //文字サイズをスクリーンサイズ x 0.15に指定
                    .font(.system(size: self.screenWidth * 0.15, weight: .thin, design: .monospaced))
                    //念の為、行数を1行に指定
                    .lineLimit(1)
                    //デフォルトの余白を追加
                    .padding()
                //表示形式が"分"の場合
           
        }
    }
}

struct TimerMainView_Previews: PreviewProvider {
    static var previews: some View {
        TimerMainView()
            .previewLayout(.sizeThatFits)
    }
}
