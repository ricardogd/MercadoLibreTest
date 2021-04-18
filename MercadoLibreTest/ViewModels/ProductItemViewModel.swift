//
//  ProductItemViewModel.swift
//  MercadoLibreTest
//
//  Created by Ricardo Grajales Duque on 18/04/21.
//

import Foundation
import SwiftUI
import Combine

class ProductItemViewModel: ObservableObject {
    
    @Published var productImage: URLImageViewModel = URLImageViewModel(url: "")
    
    //MARK: - Variables
    weak var coordinator: HomeCoordinator?
    
    //MARK: - Constructor
    init(coordinator: HomeCoordinator) {
        self.coordinator = coordinator
    }
    
    //MARK: - Navigation
    func navigateToProduct() {
        coordinator?.navigateToProduct()
    }
}
