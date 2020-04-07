//
//  PhotoResponse.swift
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
    
    @objc dynamic var keyword: String? = nil
    @objc dynamic var urls: PhotoUrls!
    
}

final class PhotoUrls: Object, Codable {
    
    @objc dynamic var regular = ""
    
}
