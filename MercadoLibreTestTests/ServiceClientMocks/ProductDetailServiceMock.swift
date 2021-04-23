//
//  ProductDetailServiceMock.swift
//  MercadoLibreTestTests
//
//  Created by Ricardo Grajales Duque on 23/04/21.
//

import Foundation
@testable import MercadoLibreTest

class ProductDetailServiceMock: ProductDetailService {
    
    var isSuccess = false
    var data = Data()
    
    override func getProductDetail(forProduct productId: String, handler: @escaping (Result<ProductDetail, ServiceErrors>) -> Void) {
        //Handling Response
        if isSuccess {
            
            //Parsing Data
            let serviceResponse: ProductDetail
            do {
                serviceResponse = try JSONDecoder().decode(ProductDetail.self, from: data)
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
    
    override func getProductDescription(withId descriptionId: String, handler: @escaping (Result<DetailDescription, ServiceErrors>) -> Void) {
        //Handling Response
        if isSuccess {
            
            //Parsing Data
            let serviceResponses: [DetailDescription]
            do {
                serviceResponses = try JSONDecoder().decode([DetailDescription].self, from: data)
            } catch {
                let json = String(data: data, encoding: .utf8)
                handler(.failure(.unableToParseResponse(error, json)))
                return
            }
            guard let serviceResponse = serviceResponses.first else {
                return handler(.failure(.missingResponse))
            }
            handler(.success(serviceResponse))
            
        }
        else {
            handler(.failure(.unknownError(nil)))
        }
    }
}
