//
//  MyEndpoint.swift
//  Sary
//
//  Created by hammam abdulaziz on 08/02/1443 AH.
//

import UIKit

protocol MyEndpoint: Endpoint { }

extension MyEndpoint {
    
    /// Base url with serviceUrl
    var url: String {
        return serviceUrl.hasPrefix("http") ? serviceUrl : (Environment.baseURL + serviceUrl)
    }
    
    /// Base headers for every request
    var defaultHeaders: [String: String] {
        var header: [String: String] = [:]
        var allHeaders = headers ?? [String: String]()
        header["language"] = (Authenticator.shared.currentLanguage?.contains("en") ?? false) ? "en" : "ar"
//        header["Content-Type"] = "application/json"
//        if let token = Authenticator.shared.token{
//            header["Authorization"] = "Bearer " + token
//        }
        //        header["App-Version"] = ""
        //        header["Accept-Language"] = "en-SA;q=1, ar-SA;q=0.9"
        //        header["User-Agent"] = "userAgent"
        //        header["Authorization"] = ""
        //        header["Accept"] = "application/json"
        allHeaders += header
        return allHeaders
    }
    
    /// Default parameters for your endpoint
    var defaultParameters: [String: Any] {
        var params: [String: Any] = [:]
        var allParameters = parameters ?? [String: Any]()
//        params["lang"] = "lang".localized
        if let token = Authenticator.shared.token{
            params["token"] = token
        }
        //        params["device_type"] = "IOS"
        //        params["API-KEY"] = Keys.apiKey
        //        params["device_token"] = "12345"
        //        params["TRANSACTION_ID"] = ""
        //        params["APP_ID"] = ""
        //        params["VERSION"] = ""
        //        params["DEVICE_ID"] = ""
        //        params["REQUEST_DATE"] = ""
        allParameters += params
        return allParameters
    }
    
    /// headers is nil because we have `defaultHeaders` and if you want to add more you
    /// can override this `headers` in your endpoint router if you need, and if you want
    /// a new headers without `defaultHeaders` you can override `defaultHeaders` in your router
    var headers: [String: String]? {
        return nil
    }
    
    /// Default method for your endpoints, override it in your endpoint router if need it
    var method: HTTPMethod {
        return .get
    }
    
    var images: [(UIImage, String)]?{
        return nil
    }
    
    var isPrintable: Bool {
        return true
    }
    
    var node: String? {
        return nil
    }
}

extension MyEndpoint {
    
    /// Request method for every endpoint
    ///
    /// - Parameter completion: Response<T>
    ///
    /// - Author: hammam abdulaziz
    func request<T: Codable>(completion: @escaping Response<T>) {
        MyApi.request(url: url,
                      headers: defaultHeaders,
                      httpMethod: method,
                      parameters: defaultParameters,
                      node: node,
                      isPrintable: isPrintable,
                      images: images,
                      completion: completion)
    }
}
