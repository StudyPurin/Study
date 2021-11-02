//
//  Record.swift
//  Study
//
//  Created by cmStudent on 2021/10/11.
//

import SwiftUI

struct RecordView: View {
    @ObservedObject var timeManager: TimeManager = .shared
    @State var editMode: EditMode = .inactive

    var body: some View {
        List{
            ForEach(0..<self.timeManager.addText.count, id: \.self) { index in
                HStack {
                    Text(self.timeManager.addText[index])
                }
            }
            .onDelete(perform: editMode.isEditing ? rowRemove : nil)
        }
        .toolbar {
            EditButton()
        }
        .environment(\.editMode, $editMode)
    }
    func rowRemove(offsets: IndexSet) {
        self.timeManager.addText.remove(atOffsets: offsets)
        UserDefaults.standard.setValue(self.timeManager.addText, forKey: "TODO")
    }
}



struct Record_Previews: PreviewProvider {
    static var previews: some View {
        RecordView()
    }
}
