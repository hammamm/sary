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
//            return "https://ezhal.com/ezhal_shops_test/public/api/sales/v1/"
            return "https://ezhal.com/ezhal_shops/public/api/sales/v1/"
        case .development:
//            return "https://ezhal.com/ezhal_shops_test/public/api/sales/v1/"
            return "https://ezhal.com/ezhal_shops/public/api/sales/v1/"
        }
    }
}
