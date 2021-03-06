//
//  Coordinator.swift
//  MercadoLibreTest
//
//  Created by Ricardo Grajales Duque on 15/04/21.
//

import Foundation
import UIKit

///Base protocol used to defined the coordinators implementations
protocol Coordinator {
    var navigationController: UINavigationController { get set }
}
