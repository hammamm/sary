//
//  Api.swift
//  Sary
//
//  Created by hammam abdulaziz on 08/02/1443 AH.
//

import UIKit

class MyApi {
    
    static func request<T: Decodable>(url: String,
                                      headers: [String: String]? = nil,
                                      httpMethod: HTTPMethod,
                                      parameters: [String: Any]? = nil,
                                      node: String?,
                                      isPrintable: Bool,
                                      completion: @escaping Response<T>) {
        
        NetworkService.request(url: url, headers: headers, httpMethod: httpMethod, parameters: parameters, isPrintable: isPrintable) { (result) in
            switch result {
            case .success(let data):
                do {
                    let data = try JSONSerialization.jsonObject(with: data, options: [])
                    let dictionary = data as? [String: Any]
                    let success = dictionary?["status"] as? Bool
                    guard success ?? false else {
                        let json = try JSONSerialization.data(withJSONObject: dictionary as Any, options: .prettyPrinted)
                        let jsonDecoder = JSONDecoder()
                        let error = try jsonDecoder.decode(ModelError.self, from: json)
                        completion(.failure(error.message))
                        return
                    }
                    
                    let node = node != nil ? dictionary?[node ?? ""] : dictionary
                    let json = try JSONSerialization.data(withJSONObject: node as Any, options: .prettyPrinted)
                    let object = try JSONDecoder().decode(T.self, from: json)
                    completion(.success(object))
                } catch let error {
                    // return decoding failed
                    logNetwork("❌ Error in Mapping\n\(url)\nError:\n\(error)")
                }
            case .failure(let error):
                completion(.failure(error.localizedDescription))
            }
        }
    }
}
