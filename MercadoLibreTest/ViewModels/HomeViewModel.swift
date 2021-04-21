//
//  HomeViewModel.swift
//  MercadoLibreTest
//
//  Created by Ricardo Grajales Duque on 16/04/21.
//

import Foundation
import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    
    //MARK: - Publisehd Variables
    @Published var categories: [CategoryDetail] = []
    @Published var products: [Product] = []
    @Published var isLoading : Bool = false
    @Published var showProductList : Bool = false
    var searchText : String = ""
    var shouldSearchForProduct : Bool = false {
        didSet {
            searchForProduct()
        }
    }
    
    //MARK: - Variables
    weak var coordinator: HomeCoordinator?
    let serviceProvider = ServiceProvider.categoriesClient

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
                
            case .failure(_):
                DispatchQueue.main.async {
                    self?.isLoading = false
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
    func navigateToCategory(withCategoryId id: String) {
        coordinator?.navigateToCategory(withCategoryId: id)
    }
    
    func navigateToProduct() {
        coordinator?.navigateToProduct()
    }
}
