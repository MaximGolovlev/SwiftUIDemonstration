//
//  ApiErrors.swift
//  SwiftUiDemonstration
//
//  Created by  Macbook on 08.09.2020.
//  Copyright © 2020 Golovelv Maxim. All rights reserved.
//

import Foundation

enum AppError: Error {
    
    case badURLRequest
    case badStatusCode(code: Int)
    case sessionFailed(error: URLError)
    case serializationError(error: Error)
    case unknownError(error: Error)
    
    var localizedDescription: String {
        switch self {
        case .badURLRequest:
            return "Parameters of provided url request is invalid"
        case .badStatusCode(let code):
            return HTTPURLResponse.localizedString(forStatusCode: code)
        case .sessionFailed(let error):
            return "session failed with error \(error)"
        case .serializationError(let error):
            return "network serialization error \(error)"
        case .unknownError(let error):
            return error.localizedDescription
        }
    }
}
