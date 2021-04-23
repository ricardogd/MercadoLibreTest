//
//  Logger.swift
//  MercadoLibreTest
//
//  Created by Ricardo Grajales Duque on 21/04/21.
//

import Foundation
import os.log

///Utility extension on charge of defining the log instances that will be used to add descriptions when failures occurs in the app or whenever a reporter can be needed
extension Logger {
    private static var subsystem = Bundle.main.bundleIdentifier!
       
    static let parsingError = Logger(subsystem: subsystem, category: "parsing")
    static let serviceCallError = Logger(subsystem: subsystem, category: "service")
    static let buildURLError = Logger(subsystem: subsystem, category: "buildURL")
    static let dataError = Logger(subsystem: subsystem, category: "dataError")
    static let showingViewSuccess = Logger(subsystem: subsystem, category: "showingView")
    
    static let showingCategoriesError = Logger(subsystem: subsystem, category: "showingCategories")
    static let showingCategoriesSuccess = Logger(subsystem: subsystem, category: "showingCategories")
    
    static let showingProductsError = Logger(subsystem: subsystem, category: "showingProducts")
    static let showingProductsSuccess = Logger(subsystem: subsystem, category: "showingProducts")
    
    static let searchProductError = Logger(subsystem: subsystem, category: "searchProduct")
    static let searchProductSuccess = Logger(subsystem: subsystem, category: "searchProduct")
    
    static let showingDetailError = Logger(subsystem: subsystem, category: "showingDetail")
    static let showingDetailSuccess = Logger(subsystem: subsystem, category: "showingDetail")
}
