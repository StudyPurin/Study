//
//  ItemStore.swift
//  Study
//
//  Created by cmStudent on 2021/10/18.
//

import RealmSwift

final class ItemStore: ObservableObject {
  
  private var itemResults: Results<ItemDB>
  
  init(realm: Realm) {
    itemResults = realm.objects(ItemDB.self)
  }
  
  var items: [Items] {
    itemResults.map(Items.init)
  }
  
}

extension ItemStore {
  func create() {
    objectWillChange.send()
    
    do {
      let realm = try Realm()
      
      let itemDB = ItemDB()
      itemDB.id = UUID().hashValue
      itemDB.title = "First Title"
      itemDB.number = Int.random(in: 0...100)
      try realm.write {
        realm.add(itemDB)
      }
    } catch let error {
      print(error.localizedDescription)
    }
  }
  
  func update(itemID: Int) {
    objectWillChange.send()
    
    do {
      let realm = try Realm()
      try realm.write {
        realm.create(ItemDB.self,
                     value: ["id": itemID, "title": "Changed Title", "number": Int.random(in: 0...100)],
                     update: .modified)
      }
    } catch let error {
      print(error.localizedDescription)
    }
  }
  
  func delete(itemID: Int) {
    objectWillChange.send()
    
    guard let itemDB = itemResults.first(where: { $0.id == itemID})
    else {
      return
    }
    
    do {
      let realm = try Realm()
      try realm.write {
        realm.delete(itemDB)
      }
    } catch let error {
      print(error.localizedDescription)
    }
  }
  
  func deleteAll() {
    objectWillChange.send()
    
    do {
      let realm = try Realm()
      try realm.write {
        realm.deleteAll()
      }
    } catch let error {
      print(error.localizedDescription)
    }
  }
}
