//
//  HomeViewModel.swift
//  MercadoLibreTest
//
//  Created by Ricardo Grajales Duque on 16/04/21.
//

import Foundation
import SwiftUI
import Combine
import os.log

class HomeViewModel: ObservableObject {
    
    //MARK: - Publisehd Variables
    @Published var categories: [CategoryDetail] = []
    @Published var products: [Product] = []
    @Published var isLoading : Bool = false
    @Published var showErrorAlert : Bool = false
    @Published var showProductList : Bool = false
    
    //MARK: - Variables
    weak var coordinator: HomeCoordinator?
    let serviceProvider = ServiceProvider.categoriesClient
    var errorMessage: String = ""
    var searchText : String = ""
    var shouldSearchForProduct : Bool = false {
        didSet {
            searchForProduct()
        }
    }

    //MARK: - Constructor
    init(coordinator: HomeCoordinator) {
        self.coordinator = coordinator
        self.isLoading = true
        getCategories()
    }
    
    //MARK: - Service Calls
    func getCategories() {
        serviceProvider.getCategories(forSite: "MCO") { [weak self] (result) in
            switch result {
            case .success(let categories):
                self?.getCategoriesWithImages(categories: categories)
                break
                
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.isLoading = false
                    self?.getErrorMessage(error: error)
                    Logger.showingCategoriesError.error("Error Showing Categories")
                }
                break
            }
        }
    }
    
    func getCategoriesWithImages(categories: [Category]) {
        let dispatchGroup = DispatchGroup()
        var categoriesDetail: [CategoryDetail] = []
        
        for category in categories {
            
            dispatchGroup.enter()
            
            serviceProvider.getCategoriesWithImages(forCategory: category.id) { (result) in
                switch result {
                case .success(let categoryDetail):
                    categoriesDetail.append(categoryDetail)
                    dispatchGroup.leave()
                    break
                    
                case .failure(_):
                    let categoryDetail = CategoryDetail(category: category)
                    categoriesDetail.append(categoryDetail)
                    dispatchGroup.leave()
                    break
                }
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            DispatchQueue.main.async {
                self.categories = categoriesDetail
                self.isLoading = false
                
                Logger.showingCategoriesSuccess.info("Showing Categories")
            }
        }
    }
    
    func searchForProduct() {
        let serviceProvider = ServiceProvider.productsClient
        DispatchQueue.main.async {
            self.isLoading = true
        }
        serviceProvider.searchForProduct(forSite: "MCO", with: searchText) { [weak self] (result) in
            switch result {
            case .success(let products):
                DispatchQueue.main.async {
                    self?.products = products.products
                    self?.showProductList = true
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
    
    //MARK: UI
    func getErrorMessage(error: ServiceErrors) {
        if !error.localizedDescription.isEmpty {
            errorMessage = error.localizedDescription
        }
        errorMessage = Localization.localizedString(fromKey: "aler.error.defaultmessage")
        showErrorAlert = true
    }
    
    //MARK: - Navigation
    func navigateToCategory(withCategoryId id: String) {
        coordinator?.navigateToCategory(withCategoryId: id)
    }
    
    func navigateToProduct(withProductId id: String) {
        coordinator?.navigateToProduct(withProductId: id)
    }
}
