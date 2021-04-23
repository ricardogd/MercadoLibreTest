//
//  GetImageServiceClient.swift
//  MercadoLibreTest
//
//  Created by Ricardo Grajales Duque on 19/04/21.
//

import Foundation

protocol GetImageServiceClient {
    /// Get image from specific URL
    /// - Parameters:
    ///   - url: URL from where to download the image
    ///   - handler: callback function to provide result or an error
    func getImage(fromURL url: String, handler: @escaping (Result<Data, ServiceErrors>) -> Void)
}
