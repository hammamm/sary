//
//  Category.swift
//  Sary
//
//  Created by hammam abdulaziz on 08/02/1443 AH.
//

import Foundation

//// MARK: - Welcome
//struct Welcome {
//    let result: [Category]
//    let message: String
//    let status: Bool
//}

// MARK: - Category
struct Category: Codable {
    let id: Int
    let title: String
    let data: [Product]
    let data_type: String
    let show_title: Bool
    let ui_type: UIType
    let row_count: Int
}

enum UIType: String, CodableEnum {
    case grid
    case linear
    case slider
}

// MARK: - Product
struct Product: Codable {
    let group_id: Int?
    let filters: [Filter]?
    let name: String?
    let image: String
    let empty_content_image: String?
    let empty_content_message: String?
    let has_data, show_unavailable_items, show_in_brochure_link: Bool?
    let deepLink: String?
}

// MARK: - Filter
struct Filter: Codable {
    let filter_id: Int
    let name: String
}
