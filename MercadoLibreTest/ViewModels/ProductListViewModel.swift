//
//  ProductItemViewModel.swift
//  MercadoLibreTest
//
//  Created by Ricardo Grajales Duque on 18/04/21.
//

import Foundation
import SwiftUI
import Combine

class ProductListViewModel: ObservableObject {
    
    //MARK: - Publisehd Variables
    @Published var isLoading : Bool = false
    @Published var products: [Product] = []
    @State var shouldSearchForProduct : Bool = false {
        didSet {
            searchForProduct()
        }
    }
    
    //MARK: - Variables
    weak var coordinator: HomeCoordinator?
    
    //MARK: - Constructor
    init(coordinator: HomeCoordinator, withCategoryId id: String) {
        self.coordinator = coordinator
        self.isLoading = true
        getProductsByCategory(categoryId: id)
    }
    
    //MARK: - Service Calls
    func searchForProduct() {
        DispatchQueue.main.async {
            self.isLoading = true
        }
    }
    
    func getProductsByCategory(categoryId: String) {
        let serviceProvider = ServiceProvider.productsClient
        serviceProvider.getProductByCategory(forSite: "MCO", with: categoryId) { [weak self] (result) in
            switch result {
            case .success(let product):
                DispatchQueue.main.async {
                    self?.products = product.products
                    self?.isLoading = false
                }
                break
            
            case .failure(_):
                DispatchQueue.main.async {
                    self?.isLoading = false
                }
                break
            }
        }
    }
    
    //MARK: - Navigation
    func navigateToProduct() {
        coordinator?.navigateToProduct()
    }
}
