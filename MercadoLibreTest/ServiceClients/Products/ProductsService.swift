//
//  ProductsByCategoryService.swift
//  MercadoLibreTest
//
//  Created by Ricardo Grajales Duque on 19/04/21.
//

import Foundation

class ProductsService: ProductsServiceClient {
    
    let session = URLSession(configuration: .default)
    
    func getProductByCategory(forSite siteId: String, with categoryId: String, handler: @escaping (Result<Products, ServiceErrors>) -> Void) {
        
        let path = URLBuilder().getProductsByCategoryPath()
        let partialPath = path.replacingOccurrences(of: "{SITE_ID}", with: siteId)
        let fullPath = partialPath.replacingOccurrences(of: "{CATEGORY_ID}", with: categoryId)
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
        
        task.resume()
    }
}
