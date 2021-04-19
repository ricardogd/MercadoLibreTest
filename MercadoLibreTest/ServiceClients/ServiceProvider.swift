//
//  ServiceProvider.swift
//  MercadoLibreTest
//
//  Created by Ricardo Grajales Duque on 18/04/21.
//

import Foundation

/// Utility class for obtaining the correct implementations for each `Service Client`
class ServiceProvider {
    static var categoriesClient: CategoriesServiceClient {
        CategoriesService()
    }
    
    static var getImageClient: GetImageServiceClient {
        GetImageService()
    }
}
