//
//  CategoriesService.swift
//  MercadoLibreTest
//
//  Created by Ricardo Grajales Duque on 18/04/21.
//

import Foundation

protocol CategoriesServiceClient {
    /// Get all the product categories avilable in each country.
    /// - Parameters:
    ///   - id: site id corresponding to each country
    ///   - handler: callback function to provide result or an error
    func getCategories(forSite id: String, handler: @escaping (Result<[Category], ServiceErrors>) -> Void)
    
    /// Get all the information for the category using the id.
    /// - Parameters:
    ///   - id: category id to get its details
    ///   - handler: callback function to provide result or an error
    func getCategoriesWithImages(forCategory id: String, handler: @escaping (Result<CategoryDetail, ServiceErrors>) -> Void)
}

