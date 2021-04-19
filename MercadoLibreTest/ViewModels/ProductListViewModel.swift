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
    func navigateToProduct() {
        coordinator?.navigateToProduct()
    }
}
