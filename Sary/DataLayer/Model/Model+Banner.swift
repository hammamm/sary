//
//  Banner.swift
//  Sary
//
//  Created by hammam abdulaziz on 08/02/1443 AH.
//

import Foundation

//// MARK: - BannerModel
//struct BannerModel {
//    let result: [Banner]
//    let status: Bool
//}

// MARK: - Banner
struct Banner: Codable {
    let id: Int
    let title, description, button_text: String
    let expiry_status: Bool
    let created_at, start_date, expiry_date: String
    let image: String
    let priority: Int
    let photo: String
    let link, level: String
    let is_available: Bool
    let branch: Int
}

// MARK: - Banner APIS
extension Banner{
    static func getList(_ completion: @escaping Response<Model<[Banner]>>) {
        _getList() { (result) in
            switch result {
                case .success(let user):
                    completion(.success(user))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
    
    private static func _getList(_ completion: @escaping Response<Model<[Banner]>>) {
        Router.BannerRouter.getList.request(completion: completion)
    }
}
