//
//  Localization.swift
//  MercadoLibreTest
//
//  Created by Ricardo Grajales Duque on 21/04/21.
//

import Foundation

/// Utility class to handle the localization for the copies in the App
class Localization {
    
    static private let bundle = Bundle.main
    
    /// This method looks for the key in the localizable strigns file and return the corresponding value. Returns empty string if can't find the key
    /// - Parameters:
    ///    - key: The key to search
    /// - Returns: The localized string
    static func localizedString(fromKey key: String) -> String {
        return bundle.localizedString(forKey: key, value: nil, table: nil)
    }
}
