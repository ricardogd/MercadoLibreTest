//
//  ProductsByCategoryService.swift
//  MercadoLibreTest
//
//  Created by Ricardo Grajales Duque on 19/04/21.
//

import Foundation
import os.log

class ProductsService: ProductsServiceClient {
    
    let session = URLSession(configuration: .default)
    
    //MARK: - Get Category Products
    func getProductByCategory(forSite siteId: String, with categoryId: String, withOffset offset: Int, handler: @escaping (Result<Products, ServiceErrors>) -> Void) {
        
        //Building URL
        let queryItem = URLQueryItem(name: Constants.categoryKey,value: categoryId)
        let offset = URLQueryItem(name: Constants.offsetKey, value: String(offset))
        let path = URLBuilder().getProductsByCategoryPath()
        let fullPath = path.replacingOccurrences(of: "{SITE_ID}", with: siteId)
        guard let url = URL(string: fullPath) else {
            Logger.buildURLError.error("Error creating the URL for get products by category service call")
            return handler(.failure(.unableToParseURL))
        }
        
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            Logger.buildURLError.error("Error creating the URL for search product service call")
            return handler(.failure(.unableToParseURL))
        }
        components.queryItems = [queryItem, offset]
        guard let composedUrl = components.url else {
            Logger.buildURLError.error("Error creating the URL for search product service call")
            return handler(.failure(.unableToParseURL))
        }
        
        //Creating Request
        var request = URLRequest(url: composedUrl)
        request.httpMethod = ServiceCommonHeaders.httpGet
        request.setValue(ServiceCommonHeaders.applicationJSON, forHTTPHeaderField: ServiceCommonHeaders.contentTypeKey)
        request.setValue(ServiceCommonHeaders.applicationJSON, forHTTPHeaderField: ServiceCommonHeaders.acceptKey)
        
        //Executing Request
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                Logger.serviceCallError.error("get products by category service error: \(error.localizedDescription)")
                handler(.failure(.unknownError(error)))
                return
            }
            
            //Handling Response
            let httpResposne = response as! HTTPURLResponse
            guard case 200..<300 = httpResposne.statusCode else {
                Logger.serviceCallError.error("get products by category service error: \(httpResposne.statusCode)")
                handler(.failure(.serviceFailure(httpResposne.statusCode)))
                return
            }
            
            guard let data = data else {
                Logger.dataError.error("get products by category service error: Missing Data")
                handler(.failure(.missingResponse))
                return
            }
            
            let serviceResponse: Products
            
            //Parsing Data
            do {
                serviceResponse = try JSONDecoder().decode(Products.self, from: data)
            } catch {
                Logger.parsingError.error("get products by category parsing error: \(error.localizedDescription)")
                let json = String(data: data, encoding: .utf8)
                handler(.failure(.unableToParseResponse(error, json)))
                return
            }

            handler(.success(serviceResponse))
        }
        
        task.resume()
    }
    
    
    //MARK: - Search Product
    func searchForProduct(forSite siteId: String, with query: String, withOffset offset: Int, handler: @escaping (Result<Products, ServiceErrors>) -> Void) {
        
        //Building URL
        let queryItem = URLQueryItem(name: Constants.queryKey,value: query)
        let offset = URLQueryItem(name: Constants.offsetKey, value: String(offset))
        let path = URLBuilder().getSearchForProductPath()
        let fullPath = path.replacingOccurrences(of: "{SITE_ID}", with: siteId)
        guard let url = URL(string: fullPath) else {
            Logger.buildURLError.error("Error creating the URL for search product service call")
            return handler(.failure(.unableToParseURL))
        }
        
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            Logger.buildURLError.error("Error creating the URL for search product service call")
            return handler(.failure(.unableToParseURL))
        }
        components.queryItems = [queryItem, offset]
        guard let composedUrl = components.url else {
            Logger.buildURLError.error("Error creating the URL for search product service call")
            return handler(.failure(.unableToParseURL))
        }
        
        //Creating Request
        var request = URLRequest(url: composedUrl)
        request.httpMethod = ServiceCommonHeaders.httpGet
        request.setValue(ServiceCommonHeaders.applicationJSON, forHTTPHeaderField: ServiceCommonHeaders.contentTypeKey)
        request.setValue(ServiceCommonHeaders.applicationJSON, forHTTPHeaderField: ServiceCommonHeaders.acceptKey)
        
        //Executing Request
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                Logger.serviceCallError.error("search product service error: \(error.localizedDescription)")
                handler(.failure(.unknownError(error)))
                return
            }
            
            //Handling Response
            let httpResposne = response as! HTTPURLResponse
            guard case 200..<300 = httpResposne.statusCode else {
                Logger.serviceCallError.error("search product service error: \(httpResposne.statusCode)")
                handler(.failure(.serviceFailure(httpResposne.statusCode)))
                return
            }
            
            guard let data = data else {
                Logger.dataError.error("search product service error: Missing Data")
                handler(.failure(.missingResponse))
                return
            }
            
            let serviceResponse: Products
            
            //Parsing Data
            do {
                serviceResponse = try JSONDecoder().decode(Products.self, from: data)
            } catch {
                Logger.parsingError.error("search product parsing error: \(error.localizedDescription)")
                let json = String(data: data, encoding: .utf8)
                handler(.failure(.unableToParseResponse(error, json)))
                return
            }

            handler(.success(serviceResponse))
        }
        
        task.resume()
    }
}

extension ProductsService {
    enum Constants {
        static let queryKey = "q"
        static let categoryKey = "category"
        static let offsetKey = "offset"
    }
}
