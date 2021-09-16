//
//  Router+User.swift
//  Sary
//
//  Created by hammam abdulaziz on 08/02/1443 AH.
//

import UIKit

extension Router {
    
    enum UserRouter: MyEndpoint {
        
        case login(user: Login)
        case getEmployeeProfile
        case getAmuontMovement
        case forgotPassword(_ mobile: String)
        case getEmployeeIncomes
        case companyTransfer
        case userProfile
        
        var serviceUrl: String {
            switch self {
            case .login:
                return api.login
            case .forgotPassword:
                return api.forgotPasswrod
            case .getAmuontMovement:
                return api.getTransfersReport
            case .getEmployeeProfile:
                return api.getEmployeeProfile
            case .getEmployeeIncomes:
                return api.employee_incomes_report
            case .companyTransfer:
                return api.employee_transfer_report
            case .userProfile:
                return api.profile
            }
        }
        
        var parameters: [String : Any]? {
            var params: [String : Any] = [:]
            switch self {
            case .login(let user):
                params["mobile"] = user.mobile
                params["password"] = user.password
            case .forgotPassword(let moblie):
                params["email"] = moblie
            case .getEmployeeProfile, .getAmuontMovement, .getEmployeeIncomes, .companyTransfer, .userProfile:
                params = [:]
            }
            return params
        }
        
        var method: HTTPMethod{
            switch self {
            case .forgotPassword:
                    return .get
            case .login, .getEmployeeProfile, .getAmuontMovement, .getEmployeeIncomes, .companyTransfer, .userProfile:
                    return .post
            }
        }
    }
}
