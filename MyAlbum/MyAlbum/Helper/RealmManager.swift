//
//  RealmManager.swift
//  MyAlbum
//
//  Created by Ronan Mak on 23/8/2023.
//

import RealmSwift

struct RealmManager {

    static let shared = RealmManager()

    private var realm: Realm?

    init() {
        do {
            realm = try Realm()
        } catch {
            print("Error initialising Realm: \(error)")
        }
    }

    // Create
    func add<T: Object>(_ object: T) {
        do {
            try realm?.write {
                realm?.add(object)
                realm?.refresh()
            }
        } catch {
            print("Realm add failed")
        }
    }

    // Delete
    func delete<T: Object>(ofType type: T.Type, with uuid: String) {
        do {
            let realm = try Realm()
            if let objectToDelete = realm.object(ofType: type, forPrimaryKey: uuid) {
                try realm.write {
                    realm.delete(objectToDelete)
                    realm.refresh()
                }
                print("Object deletion successful.")
            } else {
                print("No object of this type with this UUID found.")
            }
        } catch {
            print("Failed to delete object: \(error.localizedDescription)")
        }
    }
}
