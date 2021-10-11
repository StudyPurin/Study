//
//  SideMenuContentView.swift
//  Study
//
//  Created by cmStudent on 2021/10/11.
//

import SwiftUI

struct SideMenuView: View {
    @Binding var isOpen: Bool
    @Binding var num: Int
    let width: CGFloat = 270
    
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                EmptyView()
            }
            .background(Color.gray.opacity(0.3))
            .opacity(self.isOpen ? 1.0 : 0.0)
            .opacity(1.0)
            .animation(.easeIn(duration: 0.25))
            .onTapGesture {
                self.isOpen = false
            }
            
            HStack {
                VStack() {
                    SideMenuContentView(topPadding: 100, systemName: "books.vertical", text: "統計", isOpen: $isOpen, num: 0)
                    SideMenuContentView(systemName: "pencil", text: "記録",  isOpen: $isOpen, num: 1)
                    SideMenuContentView(systemName: "timer", text: "タイマー", isOpen: $isOpen, num: 2)
                    Spacer()
                }
                .frame(width: width)
                .background(Color(UIColor.systemGray6))
                .offset(x: self.isOpen ? 0 : -self.width)
                .animation(.easeIn(duration: 0.25))
                Spacer()
            }
        }
    }
}

// セルのビュー
struct SideMenuContentView: View {
    let topPadding: CGFloat
    let systemName: String
    let text: String
    let num: Int
    @Binding var isOpen: Bool
    
    init(topPadding: CGFloat = 30, systemName: String, text: String, isOpen: Binding<Bool>, num: Int ) {
        self.topPadding = topPadding
        self.systemName = systemName
        self._isOpen = isOpen
        self.text = text
        self.num = num
    }
    
    var body: some View {
        if (num == 0) {
            HStack {
                Image(systemName: systemName)
                    .foregroundColor(.gray)
                    .imageScale(.large)
                    .frame(width: 32.0)
                Text(text)
                    .foregroundColor(.gray)
                    .font(.headline)
                Spacer()
            }
            .padding(.top, topPadding)
            .padding(.leading, 32)
            .onTapGesture {
                ContentView()
                self.isOpen = false
            }
        }
    }
}


