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
    var paging: Paging?
    var categoryId: String
    var productServiceType: ProductServiceType?
    var errorMessage: String = ""
    var searchText : String = ""
    var searchedText: String = ""
    var shouldSearchForProduct : Bool = false {
        didSet {
            paging = nil
            products = []
            searchedText = searchText
            self.isLoading = true
            searchForProduct(withOffset: 0)
        }
    }
    
    //MARK: - Constructor
    init(coordinator: HomeCoordinator, withCategoryId id: String) {
        self.coordinator = coordinator
        self.isLoading = true
        self.categoryId = id
        getProductsByCategory(categoryId: id, withOffset: 0)
    }
    
    //MARK: - Service Calls
    func searchForProduct(withOffset offset: Int) {
        productServiceType = .searchProducts
        serviceProvider.searchForProduct(forSite: "MCO", with: searchedText, withOffset: offset) { [weak self] (result) in
            switch result {
            case .success(let products):
                DispatchQueue.main.async {
                    self?.paging = products.paging
                    self?.products.append(contentsOf: products.products)
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
    
    func getProductsByCategory(categoryId: String, withOffset offset: Int) {
        productServiceType = .categoryProducts
        serviceProvider.getProductByCategory(forSite: "MCO", with: categoryId, withOffset: offset) { [weak self] (result) in
            switch result {
            case .success(let products):
                DispatchQueue.main.async {
                    self?.paging = products.paging
                    self?.products.append(contentsOf: products.products)
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
    
    func getMoreProducts() {
        guard var paging = self.paging else {
            return
        }
        
        paging.offset = paging.offset + 50
        if paging.offset <= paging.total {

            switch productServiceType {
            case .categoryProducts:
                getProductsByCategory(categoryId: categoryId, withOffset: paging.offset)
                break
            case .searchProducts:
                searchForProduct(withOffset: paging.offset)
                break
            case .none:
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
