//
//  AnimalData.swift
//  ReadJSONFromURL
//
//  Created by Aditi Agrawal on 07/07/21.
//

import Foundation

struct AnimalData: Codable {
    
    let id: String
    let name: String?
    let image: String?
    let note: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case  name, image, note
    }
}



