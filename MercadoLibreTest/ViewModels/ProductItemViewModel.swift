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
    
    //MARK: - Publisehd Variables
    @Published var productImage: URLImageViewModel = URLImageViewModel(url: "")
    @Published var productTitle: String = ""
    @Published var productPrice: String = ""
    @Published var productCurrency: String = ""
    @Published var productInstallments: String = ""
    @Published var hasInterestRate: Bool = true
    @Published var productShipping: String = ""
    
    //MARK: - Constructor
    init() {
        //TODO: Move these calls when service had responded
        setProductPrice(price: 10000, currency: "COP")
        setProductInstallments()
        setProductShipping(isFreeShipping: true)
        setProductTitle(title: "Nombre del producto y descripción corta sobre él mismo")
    }
    
    //MARK: - UI
    func setProductTitle(title: String) {
        productTitle = title
    }
    
    func setProductPrice(price: Double, currency: String) {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        productPrice = formatter.string(from: NSNumber(value: price)) ?? "$ 0.00"
        productCurrency = currency
    }
    
    func setProductInstallments() {
        //TODO: Refactor these variables to use Installments object data returned from the service
        let numberOfPayments = 12
        let amount = 2000
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        let amountStrig = formatter.string(from: NSNumber(value: amount)) ?? "$ 0.00"
        
        productInstallments = String(numberOfPayments) + "x " + amountStrig
        hasInterestRate = false
    }
    
    func setProductShipping(isFreeShipping: Bool) {
        if isFreeShipping {
            productShipping = "Envío gratis"
        }
    }
}
