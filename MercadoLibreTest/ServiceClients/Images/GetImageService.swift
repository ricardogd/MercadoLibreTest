//
//  GetImageService.swift
//  MercadoLibreTest
//
//  Created by Ricardo Grajales Duque on 19/04/21.
//

import Foundation
import os.log

class GetImageService: GetImageServiceClient {
    
    let session = URLSession(configuration: .default)

    func getImage(fromURL urlString: String, handler: @escaping (Result<Data, ServiceErrors>) -> Void) {
        
        //Building URL
        guard let url = URL(string: urlString) else {
            Logger.parsingError.error("Error creating the URL for get Image service call")
            return handler(.failure(.unableToParseURL))
        }
        
        //Executing Request
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                Logger.serviceCallError.error("get Image service error: \(error.localizedDescription)")
                handler(.failure(.unknownError(error)))
                return
            }
            
            //Handling Response
            let httpResposne = response as! HTTPURLResponse
            guard case 200..<300 = httpResposne.statusCode else {
                Logger.serviceCallError.error("get Image service error: \(httpResposne.statusCode)")
                handler(.failure(.serviceFailure(httpResposne.statusCode)))
                return
            }
            
            //Validating Data
            guard let data = data else {
                Logger.dataError.error("get Image service error: Missing Data")
                handler(.failure(.missingResponse))
                return
            }
            
            handler(.success(data))
        }
        
        task.resume()
    }
}
