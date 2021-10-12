//
//  ContentView.swift
//  Study
//
//  Created by cmStudent on 2021/10/04.
//

import SwiftUI

struct ContentView: View {
<<<<<<< HEAD
<<<<<<< HEAD

=======
    @State var isOpenSideMenu: Bool = false
    @State var num: Int = 0
    @State var text = "Hello, World!"
>>>>>>> 2b1251e (commitTest)
    var body: some View {
            TabView {
                FirstView().tabItem {
                    Text("Command")
                    Image(systemName: "command")
                }
                SecondView().tabItem {
                    Text("Shift")
                    Image(systemName: "shift")
                }
                ThirdView().tabItem {
                    Text("Option")
                    Image(systemName: "option")
                }
=======
    var body: some View {
        TabView {
            FirstView().tabItem {
                Text("Command")
                Image(systemName: "command")
            }
            SecondView().tabItem {
                Text("Shift")
                Image(systemName: "shift")
            }
            ThirdView().tabItem {
                Text("Option")
                Image(systemName: "option")
>>>>>>> 19b6dfe (test)
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
        Text("タブメニュー３の画面")
    }
}
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }

