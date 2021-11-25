//
//  ContentView.swift
//  Study
//
//  Created by cmStudent on 2021/10/04.
//

import SwiftUI

struct ContentView: View {
    //タグの番号で画面を切り替える変数
    @State var tabSelection: Int = 0
    @ObservedObject var timeManager: TimeManager = .shared
    @Environment(\.timeZone) var timeZone
    let userDefaults:UserDefaults = UserDefaults.standard
    
    var dateFormat: DateFormatter {
        let dformat = DateFormatter()
        dformat.dateStyle = .medium
        dformat.timeStyle = .medium
        dformat.dateFormat = "yyyy-MM-dd HH:mm"
        dformat.timeZone  = timeZone
        return dformat
    }
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
        .onAppear {
            if let memo = UserDefaults.standard.array(forKey: "memo") as? [String] {
                self.timeManager.memoStudy = memo
            }
            if let hour = UserDefaults.standard.array(forKey: "hour") as? [Int] {
                self.timeManager.hourStudy = hour
            }
            if let min = UserDefaults.standard.array(forKey: "min") as? [Int] {
                self.timeManager.minStudy = min
            }
            if let date = UserDefaults.standard.array(forKey: "date") as? [Date] {
                self.timeManager.dateStudy = date
            }
            if let subject = UserDefaults.standard.array(forKey: "subject") as? [String] {
                self.timeManager.subjectStudy = subject
            }
            self.timeManager.studyTime = userDefaults.double(forKey: "study")
            
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
    @ObservedObject var timeManager: TimeManager = .shared
    var body: some View {
        SubjectView()
    }
}

struct ThirdView: View {
    @Binding var tabSelection: Int
    @ObservedObject var timeManager: TimeManager = .shared
    var body: some View {
        VStack {
            
            MainView()
            Button {
                tabSelection = 1
                self.timeManager.timeValue = self.timeManager.maxValue - self.timeManager.duration
                self.timeManager.hourSelection2 = Int(self.timeManager.timeValue) / 3600
                self.timeManager.minSelection2 = Int(self.timeManager.timeValue) % 3600 / 60
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.locale, Locale(identifier: "ja_JP"))
    }
}

