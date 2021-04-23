//
//  Installments.swift
//  MercadoLibreTest
//
//  Created by Ricardo Grajales Duque on 20/04/21.
//

import Foundation

struct Installment: Codable {
    var quantity: Int
    var amount: Double
    var rate: Double
    var currency: String
    
    enum CodingKeys: String, CodingKey {
        case quantity
        case amount
        case rate
        case currency =  "currency_id"
    }
}
