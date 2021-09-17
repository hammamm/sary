//
//  Environment.swift
//  Sary
//
//  Created by hammam abdulaziz on 08/02/1443 AH.
//

import Foundation

enum Environment {
    
    case production
    case development
    
    static var baseURL: String {
        return Environment.current == production ? production.url : development.url
    }
    
    static var current: Environment {
        #if DEBUG
        return .development
        #else
        return .production
        #endif
    }
    
    private var url: String {
        switch self {
        case .production:
            return "https://staging.sary.co/api/v2.5.1/baskets/76097/"
        case .development:
            return "https://staging.sary.co/api/v2.5.1/baskets/76097/"
        }
    }
}
