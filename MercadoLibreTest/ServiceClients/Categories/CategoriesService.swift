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
        guard let url = URL(string: path) else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = Constants.httpGet
        request.setValue(Constants.applicationJSON, forHTTPHeaderField: Constants.contentTypeKey)
        request.setValue(Constants.applicationJSON, forHTTPHeaderField: Constants.acceptKey)
        
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
        request.httpMethod = Constants.httpGet
        request.setValue(Constants.applicationJSON, forHTTPHeaderField: Constants.contentTypeKey)
        request.setValue(Constants.applicationJSON, forHTTPHeaderField: Constants.acceptKey)
        
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

extension CategoriesService {
    struct Constants {
        static let httpGet = "GET"
        static let applicationJSON = "application/json"
        static let contentTypeKey = "Content-Type"
        static let acceptKey = "Accept"
    }
}
