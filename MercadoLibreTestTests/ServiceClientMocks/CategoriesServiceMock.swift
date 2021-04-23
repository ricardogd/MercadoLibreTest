//
//  CategoriesServiceMock.swift
//  MercadoLibreTestTests
//
//  Created by Ricardo Grajales Duque on 23/04/21.
//

import Foundation
@testable import MercadoLibreTest

class CategoriesServiceMock: CategoriesService {
    
    var isSuccess = false
    var getCategoriesWithImageIsSuccess = false
    var data = Data()
    
    override func getCategories(forSite id: String, handler: @escaping (Result<[CategoryModel], ServiceErrors>) -> Void) {
        //Handling Response
        if isSuccess {
            
            //Parsing Data
            let serviceResponse: [CategoryModel]
            do {
                serviceResponse = try JSONDecoder().decode([CategoryModel].self, from: data)
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
    
    override func getCategoriesWithImages(forCategory id: String, handler: @escaping (Result<CategoryDetail, ServiceErrors>) -> Void) {
        //Handling Response
        if getCategoriesWithImageIsSuccess {
            
            //Parsing Data
            let serviceResponse: CategoryDetail
            do {
                serviceResponse = try JSONDecoder().decode(CategoryDetail.self, from: data)
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
