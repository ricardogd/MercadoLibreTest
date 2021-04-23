//
//  ProductDetailViewModelTests.swift
//  MercadoLibreTestTests
//
//  Created by Ricardo Grajales Duque on 23/04/21.
//

import Foundation
import XCTest
@testable import MercadoLibreTest

class ProductDetailViewModelTests: BaseTestClass {
    
    //MARK: - Common values
    enum Constants {
        static let productDetailJSON = "ProductDetail"
    }
    
    enum ExpectedValues {
        static let productId = "Test1"
        static let title: String = "Coche Mega Baby Bebe Convertible Tres En Uno Con Huevito + Asiento Moisés Cuna Plegable Liviano"
        static let productPrice = "$19,590.00"
        static let productCurrency: String = "ARS"
        static let productInstallments: String = "0x $0.00"
        static let hasInterestRate: Bool = true
        static let productShipping: String = "Envío gratis"
        static let productDescription: String = ""
    }
    
    //MARK: - Test Variables
    let productDetailServiceMock =  ProductDetailServiceMock()
    let getImageServiceMock = GetImageServiceMock()

    //MARK: - Tests Get Product Datails
    func testGetDetails_withProductDetailsSuccessResponseAndImageData_productDetail() {
        let data = getData(fromJSONFile: Constants.productDetailJSON)
        productDetailServiceMock.data = data ?? Data()
        productDetailServiceMock.isSuccess = true

        let imageData = getImageDataForTests()
        getImageServiceMock.data = imageData
        getImageServiceMock.isSuccess = true
        
        let coordinator = HomeCoordinator(navigationController: UINavigationController())
        let viewModel = ProductDetailViewModel(coordinator: coordinator,
                                               withProductId: ExpectedValues.productId,
                                               serviceProvider: productDetailServiceMock,
                                               getImageServiceProvider: getImageServiceMock)
        
        
        let expectation = self.expectation(description: "testGetProductDetail")
        let deadlineTime = DispatchTime.now() + .seconds(1)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
            
            XCTAssertNotNil(viewModel.detailImages)
            XCTAssertEqual(viewModel.title, ExpectedValues.title)
            XCTAssertEqual(viewModel.originalProductPrice, "")
            XCTAssertEqual(viewModel.productPrice, ExpectedValues.productPrice)
            XCTAssertEqual(viewModel.productCurrency, ExpectedValues.productCurrency)
            XCTAssertEqual(viewModel.productInstallments, ExpectedValues.productInstallments)
            XCTAssert(viewModel.hasInterestRate)
            XCTAssertEqual(viewModel.productShipping, ExpectedValues.productShipping)

            expectation.fulfill()
        }
        waitForExpectations(timeout: 5)
    }
    
    func testGetDetails_withProductDetailsSuccessResponseAndNoImageData_productDetail() {
        let data = getData(fromJSONFile: Constants.productDetailJSON)
        productDetailServiceMock.data = data ?? Data()
        productDetailServiceMock.isSuccess = true

        getImageServiceMock.isSuccess = false
        
        let coordinator = HomeCoordinator(navigationController: UINavigationController())
        let viewModel = ProductDetailViewModel(coordinator: coordinator,
                                               withProductId: ExpectedValues.productId,
                                               serviceProvider: productDetailServiceMock,
                                               getImageServiceProvider: getImageServiceMock)
        
        
        let expectation = self.expectation(description: "testGetProductDetail")
        let deadlineTime = DispatchTime.now() + .seconds(1)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
            
            XCTAssertNotNil(viewModel.detailImages)
            XCTAssertEqual(viewModel.title, ExpectedValues.title)
            XCTAssertEqual(viewModel.originalProductPrice, "")
            XCTAssertEqual(viewModel.productPrice, ExpectedValues.productPrice)
            XCTAssertEqual(viewModel.productCurrency, ExpectedValues.productCurrency)
            XCTAssertEqual(viewModel.productInstallments, ExpectedValues.productInstallments)
            XCTAssert(viewModel.hasInterestRate)
            XCTAssertEqual(viewModel.productShipping, ExpectedValues.productShipping)

            expectation.fulfill()
        }
        waitForExpectations(timeout: 5)
    }
    
    func testGetDetails_withProductDetailsFailureResponse_defaultProductDetail() {
        productDetailServiceMock.isSuccess = false
        getImageServiceMock.isSuccess = false
        
        let coordinator = HomeCoordinator(navigationController: UINavigationController())
        let viewModel = ProductDetailViewModel(coordinator: coordinator,
                                               withProductId: ExpectedValues.productId,
                                               serviceProvider: productDetailServiceMock,
                                               getImageServiceProvider: getImageServiceMock)
        
        
        let expectation = self.expectation(description: "testGetProductDetail")
        let deadlineTime = DispatchTime.now() + .seconds(1)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
            
            XCTAssertNotNil(viewModel.detailImages)
            XCTAssertEqual(viewModel.title, "")
            XCTAssertEqual(viewModel.originalProductPrice, "")
            XCTAssertEqual(viewModel.productPrice, "")
            XCTAssertEqual(viewModel.productCurrency, "")
            XCTAssertEqual(viewModel.productInstallments, "")
            XCTAssert(viewModel.hasInterestRate)
            XCTAssertEqual(viewModel.productShipping, "")

            expectation.fulfill()
        }
        waitForExpectations(timeout: 5)
    }
}
