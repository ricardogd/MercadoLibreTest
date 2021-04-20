//
//  CategoriesService.swift
//  MercadoLibreTest
//
//  Created by Ricardo Grajales Duque on 18/04/21.
//

import Foundation

class CategoriesService: CategoriesServiceClient {
    
    let session = URLSession(configuration: .default)

    func getCategories(forSite id: String, handler: @escaping (Result<[Category], ServiceErrors>) -> Void) {
        
        let path = URLBuilder().getCategoriesPath()
        let fullPath = path.replacingOccurrences(of: "{SITE_ID}", with: id)
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
            
            let serviceResponse: [Category]
            
            do {
                serviceResponse = try JSONDecoder().decode([Category].self, from: data)
            } catch {
                let json = String(data: data, encoding: .utf8)
                handler(.failure(.unableToParseResponse(error, json)))
                return
            }

            handler(.success(serviceResponse))
        }
        
        task.resume()
    }
    
    func getCategoriesWithImages(forCategory id: String, handler: @escaping (Result<CategoryDetail, ServiceErrors>) -> Void) {
        
        let path = URLBuilder().getCategoryPath()
        let fullPath = path.replacingOccurrences(of: "{CATEGORY_ID}", with: id)
        guard let url = URL(string: fullPath) else {
            return
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
        
        task.resume()
    }
}
