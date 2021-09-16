//
//  ResponseStatus.swift
//  Sary
//
//  Created by hammam abdulaziz on 08/02/1443 AH.
//

import Foundation

typealias Response<T: Codable> = (ResponseStatus<T>) -> Void

class Model<T: Codable>: Codable{
    let message: String?
    var status: Bool
    let result: T
}

enum ResponseStatus<T: Codable> {
    case success(Model<T>)
    case failure(Error)
}

