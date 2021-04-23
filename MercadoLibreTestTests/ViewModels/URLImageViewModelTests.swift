//
//  URLImageViewModelTests.swift
//  MercadoLibreTestTests
//
//  Created by Ricardo Grajales Duque on 23/04/21.
//

import Foundation
import XCTest
@testable import MercadoLibreTest

class URLImageViewModelTests: BaseTestClass {
    
    //MARK: - Common values
    enum Constants {
        static let productsJSON = "ProductsByCategory"
        static let pagingJSON = "Paging"
    }
    
    enum ExpectedValues {
        static let defaultImage = UIImage(systemName: "photo.on.rectangle")
        static let url = "Test1"
    }
    
    //MARK: - Test Variables
    let getImageServiceMock = GetImageServiceMock()
    
    //MARK: - Tests
    //Tests Get Image
    func testGetImage_withSuccesGetImageResponse_uiImage() {
        let data = getImageDataForTests()
        getImageServiceMock.data = data
        getImageServiceMock.isSuccess = true
        
        let viewModel = URLImageViewModel(url: ExpectedValues.url, serviceProvider: getImageServiceMock)
        
        let expectation = self.expectation(description: "testGetImage")
        let deadlineTime = DispatchTime.now() + .seconds(1)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
            
            XCTAssertNotNil(viewModel.image)
            XCTAssertEqual(viewModel.urlString, ExpectedValues.url)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5)
    }
    
    func testInitGetImage_withFailureGetImageResponse_defultImage() {
        getImageServiceMock.isSuccess = false
        
        let viewModel = URLImageViewModel(url: ExpectedValues.url, serviceProvider: getImageServiceMock)
        
        let expectation = self.expectation(description: "testGetImage")
        let deadlineTime = DispatchTime.now() + .seconds(1)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
            
            XCTAssertEqual(viewModel.image, ExpectedValues.defaultImage)
            XCTAssertEqual(viewModel.urlString, ExpectedValues.url)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5)
    }
}
