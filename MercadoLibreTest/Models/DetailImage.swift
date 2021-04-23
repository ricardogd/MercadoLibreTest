//
//  DetailImage.swift
//  MercadoLibreTest
//
//  Created by Ricardo Grajales Duque on 21/04/21.
//

import Foundation

struct DetailImage: Codable {
    var id: String
    var url: String
    var secureUrl: String
    var size: String
    var maxSize: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case url
        case secureUrl = "secure_url"
        case size
        case maxSize = "max_size"
    }
}
