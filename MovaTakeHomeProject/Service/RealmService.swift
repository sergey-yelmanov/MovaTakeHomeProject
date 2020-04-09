//
//  RealmService.swift
//  MovaTakeHomeProject
//
//  Created by Sergey Yelmanov on 07.04.2020.
//  Copyright © 2020 Sergey Yelmanov. All rights reserved.
//

import Foundation
import RealmSwift

final class RealmService {
    
    init() {}
    
    func getPhotos() -> Results<Photo> {
        try! Realm().objects(Photo.self).sorted(byKeyPath: "created", ascending: false)
    }
    
    func addNewPhoto(_ photo: Photo) {
        let realm = try! Realm()
        try! realm.write {
          realm.add(photo)
        }
    }
    
}
