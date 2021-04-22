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
    @Published var productImage: String = ""
    @Published var productTitle: String = ""
    @Published var productPrice: String = ""
    @Published var productCurrency: String = ""
    @Published var productInstallments: String = ""
    @Published var hasInterestRate: Bool = true
    @Published var productShipping: String = ""
    
    //MARK: - Constructor
    init(product: Product) {
        productImage = product.image ?? ""
        setProductPrice(price: product.price, currency: product.currency)
        setProductInstallments(installment: product.installments)
        setProductShipping(isFreeShipping: product.shipping?.freeShipping ?? false)
        setProductTitle(title: product.title)
    }
    
    //MARK: - UI
    func setProductTitle(title: String) {
        productTitle = title
    }
    
    func setProductPrice(price: Double, currency: String) {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.generatesDecimalNumbers = false
        formatter.alwaysShowsDecimalSeparator = false
        formatter.currencySymbol = "$"
        productPrice = formatter.string(from: NSNumber(value: price)) ?? "$ 0"
        productCurrency = currency
    }
    
    func setProductInstallments(installment: Installment?) {
        let numberOfPayments = installment?.quantity ?? 0
        let amount = installment?.amount ?? 0.0
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.generatesDecimalNumbers = false
        formatter.alwaysShowsDecimalSeparator = false
        formatter.currencySymbol = "$"
        let amountStrig = formatter.string(from: NSNumber(value: amount)) ?? "$ 0"
        
        productInstallments = String(numberOfPayments) + "x " + amountStrig
        hasInterestRate = installment?.rate ?? 1 == 0 ? false : true
    }
    
    func setProductShipping(isFreeShipping: Bool) {
        if isFreeShipping {
            productShipping = "Envío gratis"
        }
    }
}
