//
//  BaseTestClass.swift
//  MercadoLibreTestTests
//
//  Created by Ricardo Grajales Duque on 23/04/21.
//

import Foundation
import XCTest
@testable import MercadoLibreTest

///Utility class used to configure the test environment for tha App
///sets common data
///implements common functions
class BaseTestClass: XCTestCase {
    
    enum Constants {
        static let jsonExtension = "json"
    }
    
    //Process the data from mocked json files
    func getData(fromJSONFile fileName: String) -> Data? {
        guard let resourceURL = Bundle(for: type(of: self)).url(forResource: fileName, withExtension: Constants.jsonExtension) else {
            return nil
        }
        
        guard let data = try? Data(contentsOf: resourceURL) else {
            return nil
        }
        
        return data
    }
    
    //Get Paging object for testing pagination in view models
    func getPagingForTest(fromJSONFile fileName: String) -> Paging? {
        let data = getData(fromJSONFile: fileName) ?? Data()
        //Parsing Data
        let paging: Paging
        do {
            paging = try JSONDecoder().decode(Paging.self, from: data)
        } catch {
            return nil
        }
        
        return paging
    }
    
    //Get Image data from system image to use as mock data for tests
    func getImageDataForTests() -> Data {
        let image = UIImage(systemName: "moon")
        guard let imageData = image?.pngData() else {
            return Data()
        }
        
        return imageData
    }
    
    //Get Product object for testing
    func getProductForTest(fromJSONFile fileName: String) -> Product? {
        let data = getData(fromJSONFile: fileName) ?? Data()
        //Parsing Data
        let product: Product
        do {
            product = try JSONDecoder().decode(Product.self, from: data)
        } catch {
            return nil
        }
        
        return product
    }
    
    //Get Category object for testing
    func getCategoryForTest(fromJSONFile fileName: String) -> CategoryModel? {
        let data = getData(fromJSONFile: fileName) ?? Data()
        //Parsing Data
        let category: CategoryModel
        do {
            category = try JSONDecoder().decode(CategoryModel.self, from: data)
        } catch {
            return nil
        }
        
        return category
    }
}
