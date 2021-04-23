//
//  ProductDescriptionViewModel.swift
//  MercadoLibreTest
//
//  Created by Ricardo Grajales Duque on 21/04/21.
//

import Foundation
import Combine

class ProductDescriptionViewModel: ObservableObject {
    
    @Published var isLoading = false
    @Published var description: String = Localization.localizedString(fromKey: "product.descriptionmessage.placeholder")
    
    var serviceProvider: ProductDetailServiceClient
        
    init(withId descriptionId: String, serviceProvider: ProductDetailServiceClient = ServiceProvider.productDetailClient) {
        self.serviceProvider = serviceProvider
        self.isLoading = true
        getProductDescription(withId: descriptionId)
    }
    
    func getProductDescription(withId descriptionId: String) {
        serviceProvider.getProductDescription(withId: descriptionId) { [weak self] (result) in
            switch result {
            case .success(let description):
                DispatchQueue.main.async {
                    self?.description = description.plainText
                    self?.isLoading = false
                }
                break
            case .failure(_):
                DispatchQueue.main.async {
                    self?.description = Localization.localizedString(fromKey: "product.descriptionmessage.placeholder")
                    self?.isLoading = false
                }
                break
            }
        }
    }
}
