//
//  DetailDescription.swift
//  MercadoLibreTest
//
//  Created by Ricardo Grajales Duque on 21/04/21.
//

import Foundation

struct DetailDescription: Codable {
    var id: String
    var text: String
    var plainText: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case text
        case plainText = "plain_text"
    }
}
