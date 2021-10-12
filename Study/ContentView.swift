//
//  ContentView.swift
//  Study
//
//  Created by cmStudent on 2021/10/04.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            FirstView().tabItem {
                Text("統計")
                Image(systemName: "books.vertical")
            }
            SecondView().tabItem {
                Text("記録")
                Image(systemName: "pencil")
            }
            ThirdView().tabItem {
                
                Text("Option")
                Image(systemName: "option")
                
                Text("タイマー")
                Image(systemName: "timer")
            }
            FouthView().tabItem {
                Text("設定")
                Image(systemName: "gear")
                
            }
        }
    }
    struct FirstView: View {
        var body: some View {
            Text("タブメニュー１の画面")
        }
    }
    
    struct SecondView: View {
        var body: some View {
            Text("タブメニュー２の画面")
        }
    }
    
    struct ThirdView: View {
        var body: some View {
            TimerView()
        }
    }
    
    struct FouthView: View {
        var body: some View {
            Text("設定")
        }
    }
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
    
}

