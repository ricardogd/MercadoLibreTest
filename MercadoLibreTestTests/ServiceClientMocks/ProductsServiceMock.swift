//
//  ProductServiceMock.swift
//  MercadoLibreTestTests
//
//  Created by Ricardo Grajales Duque on 23/04/21.
//

import Foundation
@testable import MercadoLibreTest

class ProductsServiceMock: ProductsService {
    
    var isSuccess = false
    var data = Data()
    
    override func getProductByCategory(forSite siteId: String, with categoryId: String, withOffset offset: Int, handler: @escaping (Result<Products, ServiceErrors>) -> Void) {
        
        //Handling Response
        if isSuccess {
            
            //Parsing Data
            let serviceResponse: Products
            do {
                serviceResponse = try JSONDecoder().decode(Products.self, from: data)
            } catch {
                let json = String(data: data, encoding: .utf8)
                handler(.failure(.unableToParseResponse(error, json)))
                return
            }
            handler(.success(serviceResponse))
            
        }
        else {
            handler(.failure(.unknownError(nil)))
        }
    }
    
    override func searchForProduct(forSite siteId: String, with query: String, withOffset offset: Int, handler: @escaping (Result<Products, ServiceErrors>) -> Void) {
        
        //Handling Response
        if isSuccess {
            
            //Parsing Data
            let serviceResponse: Products
            do {
                serviceResponse = try JSONDecoder().decode(Products.self, from: data)
            } catch {
                let json = String(data: data, encoding: .utf8)
                handler(.failure(.unableToParseResponse(error, json)))
                return
            }
            handler(.success(serviceResponse))
            
        }
        else {
            handler(.failure(.unknownError(nil)))
        }
    }
}
