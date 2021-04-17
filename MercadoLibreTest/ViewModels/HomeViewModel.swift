//
//  HomeViewModel.swift
//  MercadoLibreTest
//
//  Created by Ricardo Grajales Duque on 16/04/21.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    weak var coordinator: HomeCoordinator?
    
    init(coordinator: HomeCoordinator) {
        self.coordinator = coordinator
    }
    
    func navigateTo() {
        coordinator?.navigateToDetail()
    }
}
