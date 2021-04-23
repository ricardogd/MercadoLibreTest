//
//  ProductItemViewModel.swift
//  MercadoLibreTestTests
//
//  Created by Ricardo Grajales Duque on 23/04/21.
//

import Foundation
import XCTest
@testable import MercadoLibreTest

class ProductItemViewModelTests: BaseTestClass {
    
    //MARK: - Common values
    enum Constants {
        static let productJSON = "Product"
    }
    
    enum ExpectedValues {
        static let productImage = "http://mla-s1-p.mlstatic.com/943469-MLA31002769183_062019-I.jpg"
        static let productTitle = "Samsung Galaxy J4+ Dual Sim 32 Gb Negro (2 Gb Ram)"
        static let productPrice = "$19,609.00"
        static let productCurrency = "ARS"
        static let productInstallments = "6x $3,268.17"
        static let productShipping = "Envío gratis"
        static let emptyProductPrice = "$0.00"
        static let emptyProductInstallments = "0x $0.00"
    }
    
    //MARK: - Tests Constructor
    func testInit_withProductData_productItemViewModel() {
        guard let product = getProductForTest(fromJSONFile: Constants.productJSON) else {
            XCTFail()
            return
        }
        let viewModel = ProductItemViewModel(product: product)
                
        XCTAssertEqual(viewModel.productImage, ExpectedValues.productImage)
        XCTAssertEqual(viewModel.productTitle, ExpectedValues.productTitle)
        XCTAssertEqual(viewModel.productPrice, ExpectedValues.productPrice)
        XCTAssertEqual(viewModel.productCurrency, ExpectedValues.productCurrency)
        XCTAssertEqual(viewModel.productInstallments, ExpectedValues.productInstallments)
        XCTAssertFalse(viewModel.hasInterestRate)
        XCTAssertEqual(viewModel.productShipping, ExpectedValues.productShipping)
    }
    
    func testInit_withEmptyProductData_productItemViewModel() {
        let product = Product()
        let viewModel = ProductItemViewModel(product: product)
                
        XCTAssertEqual(viewModel.productImage, "")
        XCTAssertEqual(viewModel.productTitle, "")
        XCTAssertEqual(viewModel.productPrice, ExpectedValues.emptyProductPrice)
        XCTAssertEqual(viewModel.productCurrency, "")
        XCTAssertEqual(viewModel.productInstallments, ExpectedValues.emptyProductInstallments)
        XCTAssert(viewModel.hasInterestRate)
        XCTAssertEqual(viewModel.productShipping, "")
    }
}
