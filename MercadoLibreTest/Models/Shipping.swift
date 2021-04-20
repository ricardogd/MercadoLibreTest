//
//  Shipping.swift
//  MercadoLibreTest
//
//  Created by Ricardo Grajales Duque on 20/04/21.
//

import Foundation

struct Shipping: Codable {
    
    var freeShipping: Bool
    var storePickUp: Bool
    
    enum CodingKeys: String, CodingKey {
        case freeShipping = "free_shipping"
        case storePickUp = "store_pick_up"
    }
}
