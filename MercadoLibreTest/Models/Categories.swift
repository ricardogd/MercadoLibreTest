//
//  Categories.swift
//  MercadoLibreTest
//
//  Created by Ricardo Grajales Duque on 18/04/21.
//

import Foundation

struct Category: Codable, Identifiable {
    var id: String
    var name: String
}

struct CategoryDetail: Codable, Identifiable {
    var id: String
    var name: String
    var picture: String
    
    init(category: Category) {
        id = category.id
        name = category.name
        picture = ""
    }
    
    //This is being used only for SwiftUI preview in order to keep the beneffits of this tool
    init() {
        id = ""
        name = ""
        picture = ""
    }
}
