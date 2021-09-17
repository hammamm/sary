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
        serviceUrl.hasPrefix("http") ? serviceUrl : (Environment.baseURL + serviceUrl)
    }
    
    /// Base headers for every request
    var defaultHeaders: [String: String] {
        var header: [String: String] = [:]
        var allHeaders = headers ?? [String: String]()
        header["language"] = (Authenticator.shared.currentLanguage?.contains("en") ?? false) ? "en" : "ar"
        header["Authorization"] = "token eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6ODg2NiwidXNlcl9waG9uZSI6Ijk2NjU2NDk4OTI1MCJ9.VYE28vtnMRLmwBISgvvnhOmPuGueW49ogOhXm5ZqsGU"
        header["App-Version"] = "3.1.1.0.0"
        header["Device-Type"] = "android"
                header["Accept-Language"] = "ar"
        allHeaders += header
        return allHeaders
    }
    
    /// Default parameters for your endpoint
    var defaultParameters: [String: Any] {
        let params: [String: Any] = [:]
        var allParameters = parameters ?? [String: Any]()
        allParameters += params
        return allParameters
    }
    
    /// headers is nil because we have `defaultHeaders` and if you want to add more you
    /// can override this `headers` in your endpoint router if you need, and if you want
    /// a new headers without `defaultHeaders` you can override `defaultHeaders` in your router
    var headers: [String: String]? {
        nil
    }
    
    /// Default method for your endpoints, override it in your endpoint router if need it
    var method: HTTPMethod {
        .get
    }
        
    var isPrintable: Bool {
        true
    }
    
    var node: String? {
        nil
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
                      completion: completion)
    }
}
