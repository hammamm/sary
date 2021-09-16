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
                        images: [(UIImage, String)]? = nil,
                        completion: @escaping (NetworkResponse) -> Void) {
        
        if let images = images{
            uploadRequest(url: url, headers: headers, httpMethod: httpMethod, parameters: parameters, isPrintable: isPrintable, images: images, completion: completion)
            return
        }
        
        let date = Date()
        logNetwork("""
            🙇‍♂️ \(httpMethod.rawValue.uppercased()) '\(url)':
            📝 Request headers = \(headers?.json ?? "No Headers")
            📝 Request Body = \(parameters?.json ?? "No Parameters")
            """ )
        //alamofire request
        AF.request(url,
                          method: httpMethod == .get ? .get : .post,
                          parameters: parameters,
                          headers: headers).responseJSON { response in
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
    
    
    static func uploadRequest(url: String,
                              headers: [String: String]? = nil,
                              httpMethod: HTTPMethod,
                              parameters: [String: Any]? = nil,
                              isPrintable: Bool,
                              images: [(UIImage, String)],
                              completion: @escaping (NetworkResponse) -> Void) {
        
        let date = Date()
        
        logNetwork("""
            🙇‍♂️ \(httpMethod.rawValue.uppercased()) '\(url)':
            📝 Request headers = "No Headers")
            📝 Request Body = \(parameters?.json ?? "No Parameters")
            """ )
        Alamofire.upload(multipartFormData: { multipartFormData in
            for imageData in images{
                guard let image = imageData.0.jpegData(compressionQuality: 0.5) else { continue }
                multipartFormData.append(image, withName: imageData.1,fileName: "\(date.timeIntervalSince1970).png", mimeType: "image/png")
            }
            
            for (key, value) in parameters ?? [:] {
                if let value = (value as AnyObject).data(using: String.Encoding.utf8.rawValue){
                    multipartFormData.append(value, withName: key)
                }
            }
        }, to: url, method: httpMethod == .get ? .get : .post, headers: headers) { (result) in
            switch result {
            case .success(let upload, _, _):
                upload.uploadProgress(closure: { (progress) in
                })
                upload.responseJSON { response in
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
                }
            case .failure(let error):
                completion(.failure(error))
                logNetwork("""
                    ❌ Error: \(error)
                    """ )
            }
        }
    }
}
