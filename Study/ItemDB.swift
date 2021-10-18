//
//  ItemDB.swift
//  Study
//
//  Created by cmStudent on 2021/10/18.
//

import RealmSwift
// Realm用のClass
class ItemDB: Object {
  @objc dynamic var id = 0
  @objc dynamic var title = ""
  @objc dynamic var number = 0

  // 主キーを使うと、データの更新や削除に便利
  override static func primaryKey() -> String? {
    "id"
  }
}
