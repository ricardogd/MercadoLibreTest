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
    @Published var categories = ["Comida", "Autos", "Tec", "Ropa", "Cosmeticos", "Conectividad", "TVs", "Test", "Test", "Test", "Test", "Test", "Test", "Test", "Test", "Test", "Test", "Test", "Test", "Test", "Test", "Test", "Test", "Test", "Test", "Test", "Test"]
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
    }
    
    //MARK: - Service Calls
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
    
    //MARK: UI Business Rules
    func getCategoryListItemHeight() -> CGFloat {
        guard let viewWidth = self.coordinator?.navigationController.view.frame.width else {
            return 0
        }
        
        // 0.9594 -> Aspect ratio W/H defined to resize the CategoryListItem to looks like a portrait rectangle image
        // 20 -> Widht padding used in the CategoryListItem
        let height = (viewWidth - 20) / 0.9594
        return height
    }
}
