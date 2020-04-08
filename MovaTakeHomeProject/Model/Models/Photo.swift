//
//  Photo.swift
//  MovaTakeHomeProject
//
//  Created by Sergey Yelmanov on 07.04.2020.
//  Copyright © 2020 Sergey Yelmanov. All rights reserved.
//

import Foundation
import RealmSwift

final class PhotoResponse: Codable {
    
    let results: [Photo]
    
}

final class Photo: Object, Codable {
    
    @objc dynamic var keyword = ""
    @objc dynamic var urls: PhotoUrls!
    @objc dynamic var created = Date()
    
    private enum CodingKeys: String, CodingKey {
        case urls
    }
    
}

final class PhotoUrls: Object, Codable {
    
    @objc dynamic var regular = ""
    
}
