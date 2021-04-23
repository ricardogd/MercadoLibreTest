//
//  GetImageServiceMock.swift
//  MercadoLibreTestTests
//
//  Created by Ricardo Grajales Duque on 23/04/21.
//

import Foundation
@testable import MercadoLibreTest

class GetImageServiceMock: GetImageService {
    var isSuccess = false
    var data = Data()
    
    override func getImage(fromURL urlString: String, handler: @escaping (Result<Data, ServiceErrors>) -> Void) {
        //Handling Response
        if isSuccess {
            handler(.success(data))
        }
        else {
            handler(.failure(.unknownError(nil)))
        }
    }
}
