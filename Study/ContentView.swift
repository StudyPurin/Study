//
//  ContentView.swift
//  Study
//
//  Created by cmStudent on 2021/10/04.
//

import SwiftUI

struct ContentView: View {
    @State var tabSelection: Int = 0
    var body: some View {
        TabView(selection: $tabSelection) {
            FirstView().tabItem {
                Text("統計")
                Image(systemName: "books.vertical")
            }
            .tag(0)
            SecondView(tabSelection: $tabSelection).tabItem {
                Text("記録")
                Image(systemName: "pencil")
            }
            .tag(1)
            ThirdView(tabSelection: $tabSelection).tabItem {
                Text("タイマー")
                Image(systemName: "timer")
            }
            .tag(2)
            FouthView().tabItem {
                Text("設定")
                Image(systemName: "gear")
            }
        }
    }
}

    struct FirstView: View {
        var body: some View {
            DataView()
        }
    }
    
    struct SecondView: View {
        @Binding var tabSelection: Int
        var body: some View {
            SubjectView()
        }
    }
    
    struct ThirdView: View {
        @Binding var tabSelection: Int
        var body: some View {
            VStack {
                
                MainView()
                Button {
                    tabSelection = 1
                    
                } label: {
                    Text("タイマーから記録する")
                }
            }
           
        }
    }
    
    struct FouthView: View {
        var body: some View {
            SettingView()
        }
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}

