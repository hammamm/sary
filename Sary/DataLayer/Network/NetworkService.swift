//
//  NetworkService.swift
//  Sary
//
//  Created by hammam abdulaziz on 08/02/1443 AH.
//

import Alamofire

enum NetworkResponse {
    case success(Data)
    case failure(Error)
}

class NetworkService {
    
    static func request(url: String,
                        headers: [String: String]? = nil,
                        httpMethod: HTTPMethod,
                        parameters: [String: Any]? = nil,
                        isPrintable: Bool,
                        completion: @escaping (NetworkResponse) -> Void) {
                
        let date = Date()
        logNetwork("""
            🙇‍♂️ \(httpMethod.rawValue.uppercased()) '\(url)':
            📝 Request headers = \(headers?.json ?? "No Headers")
            📝 Request Body = \(parameters?.json ?? "No Parameters")
            """ )
        
        AF.request(url, method: httpMethod == .get ? .get : .post,
                          parameters: parameters,
                          headers: HTTPHeaders(headers ??  ["":""])).responseJSON { response in
                            switch response.result {
                            case .success:
                                guard let data = response.data else { return }
                                completion(.success(data))
                                if isPrintable {
                                    logNetwork("""
                                        ✅ Response: \(response.request?.httpMethod?.uppercased() ?? "") '\(url)':
                                        🧾 Status Code: \(response.response?.statusCode ?? 0), \(response.result), 💾 \(data), ⏳ time: \(Date().timeSince(date))
                                        ⬇️ Response headers = \(response.response?.allHeaderFields.json ?? "No Headers")
                                        ⬇️ Response Body = \(String(data: data, encoding: String.Encoding.utf8) ?? "")
                                        """ )
                                }
                            case .failure(let error):
                                completion(.failure(error))
                                logNetwork("""
                                    ❌ Error in response: \(response.request?.httpMethod?.uppercased() ?? "") '\(url)' (\(response.response?.statusCode ?? 0), \(response.result)):
                                    ❌ Error: \(error)
                                    ⬇️ Response headers = \(response.response?.allHeaderFields.json ?? "No Headers")
                                    """)
                            }
        }
    }
}
