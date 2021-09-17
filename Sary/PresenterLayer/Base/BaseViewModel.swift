//
//  BaseViewModel.swift
//  Sary
//
//  Created by hammam abdulaziz on 10/02/1443 AH.
//

import UIKit
import RxSwift
import RxCocoa

class BaseViewModel {
    public var data : PublishSubject<[Any?]> = PublishSubject()
    public let loading: PublishSubject<Bool> = PublishSubject()
    public let error : PublishSubject<String> = PublishSubject()
}
