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
                
            }
                
        }
    }
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
