//
//  Router+Banner.swift
//  Sary
//
//  Created by hammam abdulaziz on 08/02/1443 AH.
//

import Foundation

extension Router{
    enum BannerRouter: MyEndpoint {
        case getList
        
        var serviceUrl: String{
            switch self {
                case .getList: return Keys.Api.getBannerList
            }
        }
    }
}
