//
//  DataView.swift
//  Study
//
//  Created by cmStudent on 2021/10/11.
//
import SwiftUI

struct DataView: View {
    @ObservedObject var timeManager: TimeManager = .shared
    @Environment(\.timeZone) var timeZone
    @State var editMode: EditMode = .inactive
    let userDefaults:UserDefaults = UserDefaults.standard
    
    
    var dateFormat: DateFormatter {
        let dformat = DateFormatter()
        dformat.dateStyle = .medium
        dformat.timeStyle = .medium
        dformat.dateFormat = "yyyy-MM-dd"
        dformat.timeZone  = timeZone
        return dformat
    }
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    HStack {
                        Text("総勉強時間")
                            .font(.headline)
                        Spacer()
                        let hr = Int(self.timeManager.studyTime) / 3600
                        let min = Int(self.timeManager.studyTime) % 3600 / 60
                        if min == 0 {
                            Text("\(hr)時間")
                                .font(.headline)
                        } else {
                            Text("\(hr)時間\(min)分")
                                .font(.headline)
                        }
                    }
                    
                    List {
                        
                        
                        ForEach(0..<timeManager.dateStudy.count, id:\.self) { index in
                            let out: Int = index
                            let date = self.timeManager.dateStudy[out]
                            let subject = self.timeManager.subjectStudy[out]
                            let hour = self.timeManager.hourStudy[out]
                            let min = self.timeManager.minStudy[out]
                            let memo = self.timeManager.memoStudy[out]
                            
                            HStack{
                                Text("\(date, formatter: dateFormat)")
                                Text("\(subject)")
                                Text("\(hour)時間\(min)分")
                                Text("\(memo)")
                            }
                        }
                        
                        
                        
                    }
                    
                }
                .navigationBarTitle("統計", displayMode: .automatic)
                .navigationViewStyle(DefaultNavigationViewStyle())
            }
        }
    }
    
    
}

struct DataView_Previews: PreviewProvider {
    static var previews: some View {
        DataView()
    }
}
