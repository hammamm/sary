//
//  Codable+Enum.swift
//  Sary
//
//  Created by hammam abdulaziz on 08/02/1443 AH.
//

import Foundation

protocol CodableEnum: Codable & CaseIterable & RawRepresentable
where RawValue: Codable, AllCases: BidirectionalCollection { }

extension CodableEnum {
    init(from decoder: Decoder) throws {
        self = try Self(rawValue: decoder.singleValueContainer().decode(RawValue.self)) ?? Self.allCases.last!
    }
}
