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
    @Published var description: String = "No se añadió ninguna descripción para éste producto."
        
    init(withId descriptionId: String) {
        self.isLoading = true
        getProductDescription(withId: descriptionId)
    }
    
    func getProductDescription(withId descriptionId: String) {
        let serviceProvider = ServiceProvider.productDetailClient
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
                    self?.description = "No se añadió ninguna descripción para éste producto."
                    self?.isLoading = false
                }
                break
            }
        }
    }
}
