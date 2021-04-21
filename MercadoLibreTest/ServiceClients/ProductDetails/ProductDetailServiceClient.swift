//
//  ProductDetailServiceClient.swift
//  MercadoLibreTest
//
//  Created by Ricardo Grajales Duque on 20/04/21.
//

import Foundation

protocol ProductDetailServiceClient {
    /// Get all the details of the product associated with the id provided.
    /// - Parameters:
    ///   - productId: product id used to request its corresponding details
    ///   - handler: callback function to provide result or an error
    func getProductDetail(forProduct productId: String, handler: @escaping (Result<ProductDetail, ServiceErrors>) -> Void)
    
    /// Get the description of the product associated.
    /// - Parameters:
    ///   - descriptionId: description id used to request its corresponding data
    ///   - handler: callback function to provide result or an error
    func getProductDescription(withId descriptionId: String, handler: @escaping (Result<DetailDescription, ServiceErrors>) -> Void)
}
