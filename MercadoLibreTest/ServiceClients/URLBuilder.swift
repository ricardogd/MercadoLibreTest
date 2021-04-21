//
//  URLBuilder.swift
//  MercadoLibreTest
//
//  Created by Ricardo Grajales Duque on 18/04/21.
//

import Foundation

/// Utility class for obtaining the correct URL for each `Service Call`
struct URLBuilder {
    
    var domain: String = ""
    
    init() {
        self.domain = getMainDomain()
    }
    
    func getCategoriesPath() -> String {
        return domain + "/sites/{SITE_ID}/categories"
    }
    
    func getCategoryPath() -> String {
        return domain + "/categories/{CATEGORY_ID}"
    }
    
    func getProductsByCategoryPath() -> String {
        return domain + "/sites/{SITE_ID}/search?category={CATEGORY_ID}"
    }
    
    func getSearchForProductPath() -> String {
        return domain + "/sites/{SITE_ID}/search"
    }
    
    func getProductDetailPath() -> String {
        return domain + "/items/{ITEM_ID}"
    }
    
    func getProductDescription() -> String {
        return domain + "/items/{ITEM_ID}/descriptions"
    }

    func getMainDomain() -> String {
        return "https://api.mercadolibre.com"
    }
}
