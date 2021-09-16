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
                                      images: [(UIImage, String)]? = nil,
                                      completion: @escaping Response<T>) {
        
        NetworkService.request(url: url, headers: headers, httpMethod: httpMethod, parameters: parameters, isPrintable: isPrintable,images: images) { (result) in
            switch result {
            case .success(let data):
                do {
                    let data = try JSONSerialization.jsonObject(with: data, options: [])
                    let dictionary = data as? [String: Any]
                    let code = dictionary?["status"] as? Int
                    guard code == 1 else {
                        let json = try JSONSerialization.data(withJSONObject: dictionary as Any, options: .prettyPrinted)
                        let jsonDecoder = JSONDecoder()
                        let error = try jsonDecoder.decode(ModelError.self, from: json)
                        completion(.failure(error))
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
                completion(.failure(error))
            }
        }
    }
}
