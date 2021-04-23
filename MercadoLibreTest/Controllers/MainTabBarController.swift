//
//  MainTabBarController.swift
//  MercadoLibreTest
//
//  Created by Ricardo Grajales Duque on 15/04/21.
//

import UIKit
import os.log

class MainTabBarController: UITabBarController {
    
    let homeCoordinator = HomeCoordinator(navigationController: UINavigationController())
    let aboutCoordinator = AboutCoordinator(navigationController: UINavigationController())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        
        viewControllers = [homeCoordinator.navigationController, aboutCoordinator.navigationController]
        
        Logger.showingViewSuccess.info("Showing Main Tab Bar Controller")
    }
}
