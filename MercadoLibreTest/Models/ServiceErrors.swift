//
//  ServiceErrors.swift
//  MercadoLibreTest
//
//  Created by Ricardo Grajales Duque on 18/04/21.
//

import Foundation

public enum ServiceErrors: Error {
    case unableToParseURL
    case missingResponse
    case serviceFailure(Int)
    case unableToParseResponse(Error, String?)
    case unknownError(Error?)
}
