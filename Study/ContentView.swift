//
//  ContentView.swift
//  Study
//
//  Created by cmStudent on 2021/10/04.
//

import SwiftUI

struct ContentView: View {
    @State var isOpenSideMenu: Bool = false
    @State var num: Int = 0
    @State var text = "Hello, World!"
    var body: some View {
<<<<<<< HEAD
        ZStack{
            NavigationView {
                Text("nu")
                    .navigationBarTitle("統計")
                    .navigationBarItems(leading: (
                        Button(action: {
                            self.isOpenSideMenu.toggle()
                        }) {
                            Image(systemName: "line.horizontal.3")
                                .imageScale(.large)
                    }))
            }
            SideMenuView(isOpen: $isOpenSideMenu, num: num)
                .edgesIgnoringSafeArea(.all)
            if num == 0 {
                
=======
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
>>>>>>> 2b1251eb3086cafebfb9ffc62d8ead5b8075be7c
            }
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
        Text("タブメニュー３の画面")
    }
}
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
