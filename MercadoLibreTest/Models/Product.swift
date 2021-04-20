//
//  Product.swift
//  MercadoLibreTest
//
//  Created by Ricardo Grajales Duque on 20/04/21.
//

import Foundation

struct Product: Codable, Identifiable {
    var id: String
    var siteId: String
    var title: String
    var price: Double
    var currency: String
    var availability: Int?
    var soldQuantity: Int?
    var image: String?
    var installments: Installment?
    var shipping: Shipping?

    enum CodingKeys: String, CodingKey {
        case id
        case siteId = "site_id"
        case title
        case price
        case currency = "currency_id"
        case availability = "available_quantity"
        case soldQuantity = "sold_quantity"
        case image = "http://mla-s1-p.mlstatic.com/943469-MLA31002769183_062019-I.jpg"
        case installments
        case shipping
    }
    
    //This is being used only for SwiftUI preview in order to keep the beneffits of this tool
    init() {
        id = ""
        siteId = ""
        title = ""
        price = 0
        currency = ""
    }
}
