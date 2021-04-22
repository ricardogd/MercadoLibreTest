//
//  CategoriesService.swift
//  MercadoLibreTest
//
//  Created by Ricardo Grajales Duque on 18/04/21.
//

import Foundation
import os.log

class CategoriesService: CategoriesServiceClient {
    
    let session = URLSession(configuration: .default)

    //MARK: - Get Categories
    func getCategories(forSite id: String, handler: @escaping (Result<[Category], ServiceErrors>) -> Void) {
        
        //Building URL
        let path = URLBuilder().getCategoriesPath()
        let fullPath = path.replacingOccurrences(of: "{SITE_ID}", with: id)
        guard let url = URL(string: fullPath) else {
            Logger.buildURLError.error("Error creating the URL for get categories service call")
            return handler(.failure(.unableToParseURL))
        }
        
        //Building Request
        var request = URLRequest(url: url)
        request.httpMethod = ServiceCommonHeaders.httpGet
        request.setValue(ServiceCommonHeaders.applicationJSON, forHTTPHeaderField: ServiceCommonHeaders.contentTypeKey)
        request.setValue(ServiceCommonHeaders.applicationJSON, forHTTPHeaderField: ServiceCommonHeaders.acceptKey)
        
        //Executing Request
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                Logger.serviceCallError.error("get categories service error: \(error.localizedDescription)")
                handler(.failure(.unknownError(error)))
                return
            }
            
            //Handling Response
            let httpResposne = response as! HTTPURLResponse
            guard case 200..<300 = httpResposne.statusCode else {
                Logger.serviceCallError.error("get categories service error: \(httpResposne.statusCode)")
                handler(.failure(.serviceFailure(httpResposne.statusCode)))
                return
            }
            
            guard let data = data else {
                Logger.dataError.error("get categories service error: Missing Data")
                handler(.failure(.missingResponse))
                return
            }
            
            let serviceResponse: [Category]
            
            //Parsing Data
            do {
                serviceResponse = try JSONDecoder().decode([Category].self, from: data)
            } catch {
                Logger.parsingError.error("get categories parsing error: \(error.localizedDescription)")
                let json = String(data: data, encoding: .utf8)
                handler(.failure(.unableToParseResponse(error, json)))
                return
            }

            handler(.success(serviceResponse))
        }
        
        task.resume()
    }
    
    //MARK: - Get Categories with Images
    func getCategoriesWithImages(forCategory id: String, handler: @escaping (Result<CategoryDetail, ServiceErrors>) -> Void) {
        
        //Building URL
        let path = URLBuilder().getCategoryPath()
        let fullPath = path.replacingOccurrences(of: "{CATEGORY_ID}", with: id)
        guard let url = URL(string: fullPath) else {
            Logger.buildURLError.error("Error creating the URL for get categories with images service call")
            return handler(.failure(.unableToParseURL))
        }
        
        //Building Request
        var request = URLRequest(url: url)
        request.httpMethod = ServiceCommonHeaders.httpGet
        request.setValue(ServiceCommonHeaders.applicationJSON, forHTTPHeaderField: ServiceCommonHeaders.contentTypeKey)
        request.setValue(ServiceCommonHeaders.applicationJSON, forHTTPHeaderField: ServiceCommonHeaders.acceptKey)
        
        //Executing Request
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                handler(.failure(.unknownError(error)))
                Logger.serviceCallError.error("get categories with images service error: \(error.localizedDescription)")
                return
            }
            
            //Handling Response
            let httpResposne = response as! HTTPURLResponse
            guard case 200..<300 = httpResposne.statusCode else {
                Logger.serviceCallError.error("get categories with images service error: \(httpResposne.statusCode)")
                handler(.failure(.serviceFailure(httpResposne.statusCode)))
                return
            }
            
            guard let data = data else {
                Logger.dataError.error("get categories with images service error: Missing Data")
                handler(.failure(.missingResponse))
                return
            }
            
            let serviceResponse: CategoryDetail
            
            //Parsing Data
            do {
                serviceResponse = try JSONDecoder().decode(CategoryDetail.self, from: data)
            } catch {
                Logger.parsingError.error("get categories with images parsing error: \(error.localizedDescription)")
                let json = String(data: data, encoding: .utf8)
                handler(.failure(.unableToParseResponse(error, json)))
                return
            }

            handler(.success(serviceResponse))
        }
        
        task.resume()
    }
}
