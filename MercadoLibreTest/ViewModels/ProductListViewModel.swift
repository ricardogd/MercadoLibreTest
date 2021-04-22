//
//  ProductItemViewModel.swift
//  MercadoLibreTest
//
//  Created by Ricardo Grajales Duque on 18/04/21.
//

import Foundation
import SwiftUI
import Combine
import os.log

class ProductListViewModel: ObservableObject {
    
    //MARK: - Published Variables
    @Published var isLoading : Bool = false
    @Published var showErrorAlert : Bool = false
    @Published var products: [Product] = []
    
    //MARK: - Variables
    weak var coordinator: HomeCoordinator?
    let serviceProvider = ServiceProvider.productsClient
    var errorMessage: String = ""
    var searchText : String = ""
    var shouldSearchForProduct : Bool = false {
        didSet {
            searchForProduct()
        }
    }
    
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
                    
                    Logger.searchProductSuccess.info("Showing products for search successfully")
                }
                break
                
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.isLoading = false
                    self?.getErrorMessage(error: error)
                    
                    Logger.searchProductError.error("Error showing products for search")
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
                    
                    Logger.showingProductsSuccess.info("Showing products by category successfully")
                }
                break
            
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.isLoading = false
                    self?.getErrorMessage(error: error)
                    
                    Logger.showingProductsError.error("Error showing products by category")
                }
                break
            }
        }
    }
    
    //MARK: UI
    func getErrorMessage(error: ServiceErrors) {
        if !error.localizedDescription.isEmpty {
            errorMessage = error.localizedDescription
        }
        errorMessage = Localization.localizedString(fromKey: "aler.error.defaultmessage")
        showErrorAlert = true
    }
    
    //MARK: - Navigation
    func navigateToProduct(withProductId id: String) {
        coordinator?.navigateToProduct(withProductId: id)
    }
}
