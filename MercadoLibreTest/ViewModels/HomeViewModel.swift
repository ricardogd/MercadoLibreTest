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
    @Published var isLoading : Bool = false
    @Published var showProductList : Bool = false
    @State var shouldSearchForProduct : Bool = false {
        didSet {
            searchForProduct()
        }
    }
    
    //MARK: - Variables
    weak var coordinator: HomeCoordinator?
    var productItemViewModel: ProductItemViewModel

    //MARK: - Constructor
    init(coordinator: HomeCoordinator) {
        self.coordinator = coordinator
        
        //TODO: Initialize this with model from service
        productItemViewModel = ProductItemViewModel()
        
        self.isLoading = true
        getCategories()
    }
    
    //MARK: - Service Calls
    func getCategories() {
        let serviceProvider = ServiceProvider.categoriesClient
        serviceProvider.getCategories(forSite: "MLA") { [weak self] (result) in
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
        let serviceProvider = ServiceProvider.categoriesClient
        
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
        DispatchQueue.main.async {
            self.isLoading = true
        }
    }
    
    //MARK: - Navigation
    func navigateToCategory() {
        coordinator?.navigateToCategory()
    }
    
    func navigateToProduct() {
        coordinator?.navigateToProduct()
    }
}
