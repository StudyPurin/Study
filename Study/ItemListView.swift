//
//  ItemList.swift
//  Study
//
//  Created by cmStudent on 2021/10/18.
//

import SwiftUI

struct ItemListView: View {
  @EnvironmentObject var store: ItemStore
  let items: [Items]
  
  var body: some View {
    List {
      Section(header: sectionHeaderView) {
        ForEach(items) { item in
          HStack{
            ItemRowView(item: item)
          }
        }
      }
    }
    .navigationTitle("RealmDBリスト")
  }
  
  var sectionHeaderView: some View {
    HStack {
      Button("追加", action: store.create)
      Spacer()
      Button("全削除", action: store.deleteAll)
    }
  }

}

struct ItemListView_Previews: PreviewProvider {
    static var previews: some View {
      ItemListView(items: ItemMock.itemMock)
    }
}
