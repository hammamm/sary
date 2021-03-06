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
            ๐โโ๏ธ \(httpMethod.rawValue.uppercased()) '\(url)':
            ๐ Request headers = \(headers?.json ?? "No Headers")
            ๐ Request Body = \(parameters?.json ?? "No Parameters")
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
                                        โ Response: \(response.request?.httpMethod?.uppercased() ?? "") '\(url)':
                                        ๐งพ Status Code: \(response.response?.statusCode ?? 0), \(response.result), ๐พ \(data), โณ time: \(Date().timeSince(date))
                                        โฌ๏ธ Response headers = \(response.response?.allHeaderFields.json ?? "No Headers")
                                        โฌ๏ธ Response Body = \(String(data: data, encoding: String.Encoding.utf8) ?? "")
                                        """ )
                                }
                            case .failure(let error):
                                completion(.failure(error))
                                logNetwork("""
                                    โ Error in response: \(response.request?.httpMethod?.uppercased() ?? "") '\(url)' (\(response.response?.statusCode ?? 0), \(response.result)):
                                    โ Error: \(error)
                                    โฌ๏ธ Response headers = \(response.response?.allHeaderFields.json ?? "No Headers")
                                    """)
                            }
        }
    }
}
