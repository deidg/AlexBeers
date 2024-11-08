//
//  BeerItem.swift
//  AlexBeerShop
//
//  Created by Alex on 18.01.2024.
//

import Foundation

struct BeerItem: Codable {
    let id: Int?
    let name: String?
    let description: String?
    let imageURL: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case imageURL = "image_url"
    }
}
