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
    ///   - offset: pagin offset for the request
    ///   - handler: callback function to provide result or an error
    func getProductByCategory(forSite siteId: String, with categoryId: String, withOffset offset: Int, handler: @escaping (Result<Products, ServiceErrors>) -> Void)
    
    /// Get all the products associated with the text introduced for searching.
    /// - Parameters:
    ///   - siteId: site id corresponding to each country
    ///   - query: the product name, description or text we want to search for
    ///   - offset: pagin offset for the request
    ///   - handler: callback function to provide result or an error
    func searchForProduct(forSite siteId: String, with query: String, withOffset offset: Int, handler: @escaping (Result<Products, ServiceErrors>) -> Void)
}
