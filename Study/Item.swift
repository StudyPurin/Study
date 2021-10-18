//
//  Item.swift
//  Study
//
//  Created by cmStudent on 2021/10/18.
//

import Foundation

struct Items: Identifiable {
  let id: Int
  let title: String
  let number: Int
}

extension Items {
  init(itemDB: ItemDB) {
    id = itemDB.id
    title = itemDB.title
    number = itemDB.number
  }
}
