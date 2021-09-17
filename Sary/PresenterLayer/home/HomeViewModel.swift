//
//  HomeViewModel.swift
//  Sary
//
//  Created by hammam abdulaziz on 10/02/1443 AH.
//

import Foundation
import RxSwift
import RxCocoa

class HomeViewModel: BaseViewModel {
    var banners: [Banner]?
    let sections = Observable.just([TableSections.banner])

    func getData() {
        Banner.getList { response in
            switch response{
                case .success(let object):
                    self.data.onNext(object.result)
                case .failure(let error):
                    self.error.onNext(error)
            }
        }
    }
}
