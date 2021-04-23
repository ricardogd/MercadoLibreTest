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
    
    static var productsClient: ProductsServiceClient {
        ProductsService()
    }
    
    static var productDetailClient: ProductDetailServiceClient {
        ProductDetailService()
    }
}

enum ServiceCommonHeaders {
    static let httpGet = "GET"
    static let applicationJSON = "application/json"
    static let contentTypeKey = "Content-Type"
    static let acceptKey = "Accept"
}
