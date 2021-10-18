//
//  Record.swift
//  Study
//
//  Created by cmStudent on 2021/10/11.
//

import SwiftUI

struct RecordView: View {
    @ObservedObject var timeManager: TimeManager = .shared
    @State var recordTimer: Int = 0

    var body: some View {
        Text("ff")
    }
}



struct Record_Previews: PreviewProvider {
    static var previews: some View {
        RecordView()
    }
}
