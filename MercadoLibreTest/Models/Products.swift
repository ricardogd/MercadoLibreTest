//
//  Products.swift
//  MercadoLibreTest
//
//  Created by Ricardo Grajales Duque on 19/04/21.
//

import Foundation

struct Products: Codable {
    var siteId: String
    var paging: Paging
    var products: [Product]
    
    enum CodingKeys: String, CodingKey {
        case siteId = "site_id"
        case paging
        case products = "results"
    }
}

enum ProductServiceType {
    case categoryProducts
    case searchProducts
}
