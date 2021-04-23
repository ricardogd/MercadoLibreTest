//
//  Paging.swift
//  MercadoLibreTest
//
//  Created by Ricardo Grajales Duque on 20/04/21.
//

import Foundation

struct Paging: Codable {
    var total: Int
    var offset: Int
    var limit: Int
    var primaryResults: Int
    
    enum CodingKeys: String, CodingKey {
        case total
        case offset
        case limit
        case primaryResults = "primary_results"
    }
}
