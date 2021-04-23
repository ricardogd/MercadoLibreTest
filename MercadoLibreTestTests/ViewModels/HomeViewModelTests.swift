//
//  HomeViewModelTests.swift
//  MercadoLibreTestTests
//
//  Created by Ricardo Grajales Duque on 23/04/21.
//

import Foundation
import XCTest
@testable import MercadoLibreTest

class HomeViewModelTests: BaseTestClass {
    //MARK: - Common values
    enum Constants {
        static let productsJSON = "ProductsByCategory"
        static let categoriesJSON = "Categories"
        static let pagingJSON = "Paging"
    }
    
    enum ExpectedValues {
        static let categoryProductsCount = 2
        static let categoriesCount = 31
        static let categoryId = "Test1"
    }
    
    //MARK: - Test Variables
    let productsServiceMock = ProductsServiceMock()
    let categoriesServiceMock = CategoriesServiceMock()
    
    //MARK: - Tests
    //Tests Constructor
    func testInit_withAllParameters_defaultProductListViewModelInstance() {
        let coordinator = HomeCoordinator(navigationController: UINavigationController())
        let viewModel = HomeViewModel(coordinator: coordinator)
        
        XCTAssert(viewModel.products.isEmpty)
    }
    
    //Tests Get Categories
    func testGetCategories_withCategoriesSuccessResponse_productsArray() {
        let data = getData(fromJSONFile: Constants.categoriesJSON)
        categoriesServiceMock.data = data ?? Data()
        categoriesServiceMock.isSuccess = true
        
        let coordinator = HomeCoordinator(navigationController: UINavigationController())
        let viewModel = HomeViewModel(coordinator: coordinator, categoriesServiceProvider: categoriesServiceMock)
        viewModel.getCategories()
        
        let expectation = self.expectation(description: "testGetCategories")
        let deadlineTime = DispatchTime.now() + .seconds(1)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
            
            XCTAssertEqual(viewModel.categories.count, ExpectedValues.categoriesCount)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5)
    }
    
    func testGetCategories_withCategoriesFailureResponse_emptyProductsArray() {
        categoriesServiceMock.isSuccess = false
        categoriesServiceMock.getCategoriesWithImageIsSuccess = false
        
        let coordinator = HomeCoordinator(navigationController: UINavigationController())
        let viewModel = HomeViewModel(coordinator: coordinator, categoriesServiceProvider: categoriesServiceMock)
        viewModel.getCategories()
        
        let expectation = self.expectation(description: "testGetCategories")
        let deadlineTime = DispatchTime.now() + .seconds(1)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
            
            print(viewModel.categories)
            XCTAssert(viewModel.categories.isEmpty)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5)
    }
    
    //Tests Searc Product
    func testSearchForProduct_withProductsSuccessResponse_productsArray() {
        let data = getData(fromJSONFile: Constants.productsJSON)
        productsServiceMock.data = data ?? Data()
        productsServiceMock.isSuccess = true
        
        let coordinator = HomeCoordinator(navigationController: UINavigationController())
        let viewModel = HomeViewModel(coordinator: coordinator, productServiceProvider: productsServiceMock)
        viewModel.searchForProduct(withOffset: 0)
        
        let expectation = self.expectation(description: "testGetProductsByCategory")
        let deadlineTime = DispatchTime.now() + .seconds(1)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
            
            XCTAssertEqual(viewModel.products.count, ExpectedValues.categoryProductsCount)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5)
    }
    
    func testSearchForProduct_withProductsFailureResponse_emptyProductsArray() {
        productsServiceMock.isSuccess = false
        
        let coordinator = HomeCoordinator(navigationController: UINavigationController())
        let viewModel = HomeViewModel(coordinator: coordinator, productServiceProvider: productsServiceMock)
        viewModel.searchForProduct(withOffset: 0)
        
        let expectation = self.expectation(description: "testGetProductsByCategory")
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
        
        let coordinator = HomeCoordinator(navigationController: UINavigationController())
        let viewModel = HomeViewModel(coordinator: coordinator, productServiceProvider: productsServiceMock)

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
    func testGetMoreProducts_withProductsSuccessResponse_productsArray() {
        let data = getData(fromJSONFile: Constants.productsJSON)
        productsServiceMock.data = data ?? Data()
        productsServiceMock.isSuccess = true
        
        let coordinator = HomeCoordinator(navigationController: UINavigationController())
        let viewModel = HomeViewModel(coordinator: coordinator, productServiceProvider: productsServiceMock)
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
    
    func testGetMoreProducts_withProductsFailureResponse_emptyProductsArray() {
        productsServiceMock.isSuccess = false
        
        let coordinator = HomeCoordinator(navigationController: UINavigationController())
        let viewModel = HomeViewModel(coordinator: coordinator, productServiceProvider: productsServiceMock)
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
