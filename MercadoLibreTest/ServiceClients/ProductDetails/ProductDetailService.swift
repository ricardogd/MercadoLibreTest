//
//  ProductDetailService.swift
//  MercadoLibreTest
//
//  Created by Ricardo Grajales Duque on 20/04/21.
//

import Foundation

class ProductDetailService: ProductDetailServiceClient {
    
    let session = URLSession(configuration: .default)
    
    func getProductDetail(forProduct productId: String, handler: @escaping (Result<ProductDetail, ServiceErrors>) -> Void) {
        
        let queryItem = URLQueryItem(name: Constants.includeKey,value: Constants.allKey)
        let path = URLBuilder().getProductDetailPath()
        let fullPath = path.replacingOccurrences(of: "{ITEM_ID}", with: productId)
        guard let url = URL(string: fullPath) else {
            return handler(.failure(.unableToParseURL))
        }
        
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            return handler(.failure(.unableToParseURL))
        }
        components.queryItems = [queryItem]
        guard let composedUrl = components.url else {
            return handler(.failure(.unableToParseURL))
        }
        
        var request = URLRequest(url: composedUrl)
        request.httpMethod = ServiceCommonHeaders.httpGet
        request.setValue(ServiceCommonHeaders.applicationJSON, forHTTPHeaderField: ServiceCommonHeaders.contentTypeKey)
        request.setValue(ServiceCommonHeaders.applicationJSON, forHTTPHeaderField: ServiceCommonHeaders.acceptKey)
        
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                handler(.failure(.unknownError(error)))
                return
            }
            
            let httpResposne = response as! HTTPURLResponse
            guard case 200..<300 = httpResposne.statusCode else {
                handler(.failure(.serviceFailure(httpResposne.statusCode)))
                return
            }
            
            guard let data = data else {
                handler(.failure(.missingResponse))
                return
            }
            
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
        
        task.resume()
    }
    
    func getProductDescription(withId descriptionId: String, handler: @escaping (Result<DetailDescription, ServiceErrors>) -> Void) {
        
        let path = URLBuilder().getProductDescription()
        let fullPath = path.replacingOccurrences(of: "{ITEM_ID}", with: descriptionId)
        guard let url = URL(string: fullPath) else {
            return handler(.failure(.unableToParseURL))
        }

        var request = URLRequest(url: url)
        request.httpMethod = ServiceCommonHeaders.httpGet
        request.setValue(ServiceCommonHeaders.applicationJSON, forHTTPHeaderField: ServiceCommonHeaders.contentTypeKey)
        request.setValue(ServiceCommonHeaders.applicationJSON, forHTTPHeaderField: ServiceCommonHeaders.acceptKey)
        
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                handler(.failure(.unknownError(error)))
                return
            }
            
            let httpResposne = response as! HTTPURLResponse
            guard case 200..<300 = httpResposne.statusCode else {
                handler(.failure(.serviceFailure(httpResposne.statusCode)))
                return
            }
            
            guard let data = data else {
                handler(.failure(.missingResponse))
                return
            }
            
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
        
        task.resume()
    }
}

extension ProductDetailService {
    enum Constants {
        static let includeKey = "include_attributes"
        static let allKey = "all"
    }
}
