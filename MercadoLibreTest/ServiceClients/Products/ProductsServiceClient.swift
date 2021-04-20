//
//  ProductsServiceClient.swift
//  MercadoLibreTest
//
//  Created by Ricardo Grajales Duque on 19/04/21.
//

import Foundation

protocol ProductsServiceClient {
    /// Get all the products associated with each category.
    /// - Parameters:
    ///   - siteId: site id corresponding to each country
    ///   - categoryId: the category id used to request the products associated to itself
    ///   - handler: callback function to provide result or an error
    func getProductByCategory(forSite siteId: String, with categoryId: String, handler: @escaping (Result<Products, ServiceErrors>) -> Void)
}
