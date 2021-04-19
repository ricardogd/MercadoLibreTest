//
//  GetImageService.swift
//  MercadoLibreTest
//
//  Created by Ricardo Grajales Duque on 19/04/21.
//

import Foundation

class GetImageService: GetImageServiceClient {
    
    let session = URLSession(configuration: .default)

    func getImage(fromURL urlString: String, handler: @escaping (Result<Data, ServiceErrors>) -> Void) {
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        let task = session.dataTask(with: url) { (data, response, error) in
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
            
            handler(.success(data))
        }
        
        task.resume()
    }
}
