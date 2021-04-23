//
//  ProductDetailService.swift
//  MercadoLibreTest
//
//  Created by Ricardo Grajales Duque on 20/04/21.
//

import Foundation
import os.log

class ProductDetailService: ProductDetailServiceClient {
    
    let session = URLSession(configuration: .default)
    
    //MARK: - Get Details
    func getProductDetail(forProduct productId: String, handler: @escaping (Result<ProductDetail, ServiceErrors>) -> Void) {
        
        //Building URL
        let queryItem = URLQueryItem(name: Constants.includeKey,value: Constants.allKey)
        let path = URLBuilder().getProductDetailPath()
        let fullPath = path.replacingOccurrences(of: "{ITEM_ID}", with: productId)
        guard let url = URL(string: fullPath) else {
            Logger.buildURLError.error("Error creating the URL for get product detail service call")
            return handler(.failure(.unableToParseURL))
        }
        
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            Logger.buildURLError.error("Error creating the URL for get product detail service call")
            return handler(.failure(.unableToParseURL))
        }
        components.queryItems = [queryItem]
        guard let composedUrl = components.url else {
            Logger.buildURLError.error("Error creating the URL for get product detail service call")
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
                Logger.serviceCallError.error("get product detail service error: \(error.localizedDescription)")
                handler(.failure(.unknownError(error)))
                return
            }
            
            //Handling Response
            let httpResposne = response as! HTTPURLResponse
            guard case 200..<300 = httpResposne.statusCode else {
                Logger.serviceCallError.error("get product detail service error: \(httpResposne.statusCode)")
                handler(.failure(.serviceFailure(httpResposne.statusCode)))
                return
            }
            
            guard let data = data else {
                Logger.dataError.error("get product detail service error: Missing Data")
                handler(.failure(.missingResponse))
                return
            }
            
            let serviceResponse: ProductDetail
            
            //Parsing Data
            do {
                serviceResponse = try JSONDecoder().decode(ProductDetail.self, from: data)
            } catch {
                Logger.parsingError.error("get product detail parsing error: \(error.localizedDescription)")
                let json = String(data: data, encoding: .utf8)
                handler(.failure(.unableToParseResponse(error, json)))
                return
            }

            handler(.success(serviceResponse))
        }
        
        task.resume()
    }
    
    //MARK: - Get Description
    func getProductDescription(withId descriptionId: String, handler: @escaping (Result<DetailDescription, ServiceErrors>) -> Void) {
        
        //Building URL
        let path = URLBuilder().getProductDescription()
        let fullPath = path.replacingOccurrences(of: "{ITEM_ID}", with: descriptionId)
        guard let url = URL(string: fullPath) else {
            Logger.buildURLError.error("Error creating the URL for get product description service call")
            return handler(.failure(.unableToParseURL))
        }

        //Creating Request
        var request = URLRequest(url: url)
        request.httpMethod = ServiceCommonHeaders.httpGet
        request.setValue(ServiceCommonHeaders.applicationJSON, forHTTPHeaderField: ServiceCommonHeaders.contentTypeKey)
        request.setValue(ServiceCommonHeaders.applicationJSON, forHTTPHeaderField: ServiceCommonHeaders.acceptKey)
        
        //Executing Request
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                Logger.serviceCallError.error("get product description service error: \(error.localizedDescription)")
                handler(.failure(.unknownError(error)))
                return
            }
            
            //Handling Response
            let httpResposne = response as! HTTPURLResponse
            guard case 200..<300 = httpResposne.statusCode else {
                Logger.serviceCallError.error("get product description service error: \(httpResposne.statusCode)")
                handler(.failure(.serviceFailure(httpResposne.statusCode)))
                return
            }
            
            guard let data = data else {
                Logger.dataError.error("get product description service error: Missing Data")
                handler(.failure(.missingResponse))
                return
            }
            
            let serviceResponses: [DetailDescription]
            
            //Parsing Data
            do {
                serviceResponses = try JSONDecoder().decode([DetailDescription].self, from: data)
            } catch {
                Logger.parsingError.error("get product description parsing error: \(error.localizedDescription)")
                let json = String(data: data, encoding: .utf8)
                handler(.failure(.unableToParseResponse(error, json)))
                return
            }
            guard let serviceResponse = serviceResponses.first else {
                Logger.dataError.error("get product description service error: Missing Data")
                return handler(.failure(.missingResponse))
            }

            handler(.success(serviceResponse))
        }
        
        task.resume()
    }
}

extension ProductDetailService {
    enum Constants {
        static let includeKey = "include_attributes"
        static let allKey = "all"
    }
}
