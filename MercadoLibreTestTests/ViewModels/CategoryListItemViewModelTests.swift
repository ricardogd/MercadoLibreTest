//
//  CategoryListItemViewModelTests.swift
//  MercadoLibreTestTests
//
//  Created by Ricardo Grajales Duque on 23/04/21.
//

import Foundation
import XCTest
@testable import MercadoLibreTest

class CategoryListItemViewModelTests: BaseTestClass {
    
    //MARK: - Common values
    enum Constants {
        static let categoryJSON = "Category"
    }
    
    enum ExpectedValues {
        static let defaultImage = UIImage(named: "CategoryPlaceHolder")
        static let name = "Accesorios para Vehículos"
    }
    
    //MARK: - Test Variables
    let getImageServiceMock = GetImageServiceMock()
    
    func testInit_withCategoryDataAndGetImageSuccessResponse_categoryListItem() {
        guard let category = getCategoryForTest(fromJSONFile: Constants.categoryJSON) else {
            XCTFail()
            return
        }
        let categoryDetail = CategoryDetail(category: category)
        
        let data = getImageDataForTests()
        getImageServiceMock.data = data
        getImageServiceMock.isSuccess = true
        
        let viewModel = CategoryListItemViewModel(categoryDetail: categoryDetail, serviceProvider: getImageServiceMock)
        
        XCTAssertNotNil(viewModel.image)
        XCTAssertEqual(viewModel.name, ExpectedValues.name)
        XCTAssertEqual(Int(viewModel.listItemHeight), 410)
    }
    
    func testInit_withCategoryDataAndGetImageFailureResponse_categoryListItemWithDefaultImage() {
        guard let category = getCategoryForTest(fromJSONFile: Constants.categoryJSON) else {
            XCTFail()
            return
        }
        let categoryDetail = CategoryDetail(category: category)
        
        getImageServiceMock.isSuccess = false
        
        let viewModel = CategoryListItemViewModel(categoryDetail: categoryDetail, serviceProvider: getImageServiceMock)
        
        XCTAssertEqual(viewModel.image, ExpectedValues.defaultImage)
        XCTAssertEqual(viewModel.name, ExpectedValues.name)
        XCTAssertEqual(Int(viewModel.listItemHeight), 410)
    }
}
