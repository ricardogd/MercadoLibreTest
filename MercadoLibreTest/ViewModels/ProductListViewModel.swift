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
    var searchText : String = ""
    var shouldSearchForProduct : Bool = false {
        didSet {
            searchForProduct()
        }
    }
    
    //MARK: - Variables
    weak var coordinator: HomeCoordinator?
    let serviceProvider = ServiceProvider.productsClient
    
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
        
        serviceProvider.searchForProduct(forSite: "MCO", with: searchText) { [weak self] (result) in
            switch result {
            case .success(let products):
                DispatchQueue.main.async {
                    self?.products = products.products
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
    
    func getProductsByCategory(categoryId: String) {
        serviceProvider.getProductByCategory(forSite: "MCO", with: categoryId) { [weak self] (result) in
            switch result {
            case .success(let products):
                DispatchQueue.main.async {
                    self?.products = products.products
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
