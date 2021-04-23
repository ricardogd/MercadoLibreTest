//
//  ProductListViewModelTests.swift
//  MercadoLibreTestTests
//
//  Created by Ricardo Grajales Duque on 23/04/21.
//

import Foundation
import XCTest
@testable import MercadoLibreTest

class ProductListViewModelTests: BaseTestClass {
    
    //MARK: - Common values
    enum Constants {
        static let productsJSON = "ProductsByCategory"
        static let pagingJSON = "Paging"
    }
    
    enum ExpectedValues {
        static let categoryProductsCount = 4
        static let categoryId = "Test1"
    }
    
    //MARK: - Test Variables
    let productsServiceMock = ProductsServiceMock()
    
    //MARK: - Tests
    //Tests Constructor
    func testInit_withAllParameters_defaultProductListViewModelInstance() {
        let coordinator = HomeCoordinator(navigationController: UINavigationController())
        let categoryId = ExpectedValues.categoryId
        let viewModel = ProductListViewModel(coordinator: coordinator,
                                             withCategoryId: categoryId,
                                             serviceProvider: productsServiceMock)
        
        XCTAssertEqual(viewModel.categoryId, ExpectedValues.categoryId)
        XCTAssert(viewModel.products.isEmpty)
    }
    
    //Tests Get Product
    func testGetProductsByCategory_withProductsSuccessResponse_productsArray() {
        let data = getData(fromJSONFile: Constants.productsJSON)
        productsServiceMock.data = data ?? Data()
        productsServiceMock.isSuccess = true
        
        let categoryId = ExpectedValues.categoryId
        let coordinator = HomeCoordinator(navigationController: UINavigationController())
        let viewModel = ProductListViewModel(coordinator: coordinator,
                                             withCategoryId: categoryId,
                                             serviceProvider: productsServiceMock)
        viewModel.getProductsByCategory(categoryId: categoryId, withOffset: 0)
        
        let expectation = self.expectation(description: "testGetProductsByCategory")
        let deadlineTime = DispatchTime.now() + .seconds(1)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
            
            XCTAssertEqual(viewModel.products.count, ExpectedValues.categoryProductsCount)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5)
    }
    
    func testGetProductsByCategory_withProductsFailureResponse_emptyProductsArray() {
        productsServiceMock.isSuccess = false
        
        let categoryId = ExpectedValues.categoryId
        let coordinator = HomeCoordinator(navigationController: UINavigationController())
        let viewModel = ProductListViewModel(coordinator: coordinator,
                                             withCategoryId: categoryId,
                                             serviceProvider: productsServiceMock)
        viewModel.getProductsByCategory(categoryId: categoryId, withOffset: 0)
        
        let expectation = self.expectation(description: "testGetProductsByCategory")
        let deadlineTime = DispatchTime.now() + .seconds(1)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
            
            XCTAssert(viewModel.products.isEmpty)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5)
    }
    
    //Tests Search Product
    func testSearchForProduct_withProductsSuccessResponse_productsArray() {
        let data = getData(fromJSONFile: Constants.productsJSON)
        productsServiceMock.data = data ?? Data()
        productsServiceMock.isSuccess = true
        
        let categoryId = ExpectedValues.categoryId
        let coordinator = HomeCoordinator(navigationController: UINavigationController())
        let viewModel = ProductListViewModel(coordinator: coordinator,
                                             withCategoryId: categoryId,
                                             serviceProvider: productsServiceMock)
        viewModel.searchedText = "Testing"
        viewModel.searchForProduct(withOffset: 0)
        
        let expectation = self.expectation(description: "testSearchProduct")
        let deadlineTime = DispatchTime.now() + .seconds(1)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
            
            XCTAssertEqual(viewModel.products.count, ExpectedValues.categoryProductsCount)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5)
    }
    
    func testSearchForProduct_withProductsFailureResponse_emptyProductsArray() {
        productsServiceMock.isSuccess = false
        
        let categoryId = ExpectedValues.categoryId
        let coordinator = HomeCoordinator(navigationController: UINavigationController())
        let viewModel = ProductListViewModel(coordinator: coordinator,
                                             withCategoryId: categoryId,
                                             serviceProvider: productsServiceMock)
        viewModel.searchedText = "Testing"
        viewModel.searchForProduct(withOffset: 0)
        
        let expectation = self.expectation(description: "testSearchProduct")
        let deadlineTime = DispatchTime.now() + .seconds(1)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
            
            XCTAssert(viewModel.products.isEmpty)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5)
    }
    
    func testSearchForProductFromSearchAction_withProductsSuccessResponse_productsArray() {
        let data = getData(fromJSONFile: Constants.productsJSON)
        productsServiceMock.data = data ?? Data()
        productsServiceMock.isSuccess = true
        
        let categoryId = ExpectedValues.categoryId
        let coordinator = HomeCoordinator(navigationController: UINavigationController())
        let viewModel = ProductListViewModel(coordinator: coordinator,
                                             withCategoryId: categoryId,
                                             serviceProvider: productsServiceMock)
        viewModel.searchedText = "Testing"
        viewModel.shouldSearchForProduct = true
        
        let expectation = self.expectation(description: "testSearchProduct")
        let deadlineTime = DispatchTime.now() + .seconds(1)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
            
            XCTAssertEqual(viewModel.products.count, ExpectedValues.categoryProductsCount)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5)
    }
    
    //Tests Get More Products
    func testGetMoreProducts_withCategoryProductsServiceTypeAndSuccessResponse_productsArray() {
        let data = getData(fromJSONFile: Constants.productsJSON)
        productsServiceMock.data = data ?? Data()
        productsServiceMock.isSuccess = true
        
        let categoryId = ExpectedValues.categoryId
        let coordinator = HomeCoordinator(navigationController: UINavigationController())
        let viewModel = ProductListViewModel(coordinator: coordinator,
                                             withCategoryId: categoryId,
                                             serviceProvider: productsServiceMock)
        viewModel.searchedText = "Testing"
        viewModel.productServiceType = .categoryProducts
        viewModel.paging = getPagingForTest(fromJSONFile: Constants.pagingJSON)
        viewModel.getMoreProducts()
        
        let expectation = self.expectation(description: "testSearchProduct")
        let deadlineTime = DispatchTime.now() + .seconds(1)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
            
            XCTAssertEqual(viewModel.products.count, ExpectedValues.categoryProductsCount)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5)
    }
    
    func testGetMoreProducts_withCategoryProductsServiceTypeAndFailureResponse_emptyProductsArray() {
        productsServiceMock.isSuccess = false
        
        let categoryId = ExpectedValues.categoryId
        let coordinator = HomeCoordinator(navigationController: UINavigationController())
        let viewModel = ProductListViewModel(coordinator: coordinator,
                                             withCategoryId: categoryId,
                                             serviceProvider: productsServiceMock)
        viewModel.searchedText = "Testing"
        viewModel.productServiceType = .categoryProducts
        viewModel.getMoreProducts()
        
        let expectation = self.expectation(description: "testGetMoreProducts")
        let deadlineTime = DispatchTime.now() + .seconds(1)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
            
            XCTAssert(viewModel.products.isEmpty)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5)
    }
    
    func testGetMoreProducts_withSearchProductsServiceTypeAndSuccessResponse_productsArray() {
        let data = getData(fromJSONFile: Constants.productsJSON)
        productsServiceMock.data = data ?? Data()
        productsServiceMock.isSuccess = true
        
        let categoryId = ExpectedValues.categoryId
        let coordinator = HomeCoordinator(navigationController: UINavigationController())
        let viewModel = ProductListViewModel(coordinator: coordinator,
                                             withCategoryId: categoryId,
                                             serviceProvider: productsServiceMock)
        viewModel.searchedText = "Testing"
        viewModel.productServiceType = .searchProducts
        viewModel.paging = getPagingForTest(fromJSONFile: Constants.pagingJSON)
        viewModel.getMoreProducts()
        
        let expectation = self.expectation(description: "testGetMoreProducts")
        let deadlineTime = DispatchTime.now() + .seconds(1)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
            
            XCTAssertEqual(viewModel.products.count, ExpectedValues.categoryProductsCount)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5)
    }
    
    func testGetMoreProducts_withSearchProductsServiceTypeAndFailureResponse_emptyProductsArray() {
        productsServiceMock.isSuccess = false
        
        let categoryId = ExpectedValues.categoryId
        let coordinator = HomeCoordinator(navigationController: UINavigationController())
        let viewModel = ProductListViewModel(coordinator: coordinator,
                                             withCategoryId: categoryId,
                                             serviceProvider: productsServiceMock)
        viewModel.searchedText = "Testing"
        viewModel.productServiceType = .searchProducts
        viewModel.getMoreProducts()
        
        let expectation = self.expectation(description: "testGetMoreProducts")
        let deadlineTime = DispatchTime.now() + .seconds(1)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
            
            XCTAssert(viewModel.products.isEmpty)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5)
    }
}
