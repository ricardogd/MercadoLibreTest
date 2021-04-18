//
//  MainCoordinator.swift
//  MercadoLibreTest
//
//  Created by Ricardo Grajales Duque on 15/04/21.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    
    //MARK: - Coordinator Delegate implementation
    var navigationController: UINavigationController

    //MARK: - Constructor
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        setUpNavigationController()
    }
    
    //MARK: - SetUp
    func setUpNavigationController() {
        self.navigationController.navigationBar.prefersLargeTitles = true
        self.navigationController.navigationItem.largeTitleDisplayMode = .always
    }

    //MARK: - Navigation
    func start() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: String(describing: MainTabBarController.self)) as? MainTabBarController else {
            return
        }
        navigationController.pushViewController(vc, animated: true)
    }
}
