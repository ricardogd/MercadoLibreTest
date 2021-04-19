//
//  URLBuilder.swift
//  MercadoLibreTest
//
//  Created by Ricardo Grajales Duque on 18/04/21.
//

import Foundation

/// Utility class for obtaining the correct URL for each `Service Call`
struct URLBuilder {
    
    var domain: String!
    
    init() {
        self.domain = getMainDomain()
    }
    
    func getCategoriesPath() -> String {
        return domain + "/sites/MLA/categories"
    }
    
    func getCategoryPath() -> String {
        return domain + "/categories/{CATEGORY_ID}"
    }

    func getMainDomain() -> String {
        return "https://api.mercadolibre.com"
    }
}
