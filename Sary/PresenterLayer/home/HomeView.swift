//
//  HomeView.swift
//  Sary
//
//  Created by hammam abdulaziz on 10/02/1443 AH.
//

import UIKit
import RxSwift
import RxCocoa

class HomeView: BaseView {

    @IBOutlet weak var tableView: UITableView!

    public var data = PublishSubject<[Any?]>()
    public var success = PublishSubject<Any>()
    let disposeBag = DisposeBag()
    
    let viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    private func configuration() {
        viewModel.loading.bind(onNext: self.loading(_:)).disposed(by: disposeBag)
        viewModel.error.observe(on: MainScheduler.instance).subscribe { error in
            self.error = error
        }.disposed(by: disposeBag)
        viewModel.sections.bind(to: tableView.rx.items){ table, index, section in

            switch section{
                case .banner: return self.bannerCell(with: table, and: index, of: section)
            }
        }.disposed(by: disposeBag)
    }
    
    func bannerCell(with table: UITableView, and index: Int, of section: TableSections) -> UITableViewCell {
        guard let cell = table.dequeueReusableCell(withIdentifier: BannerTableViewCell.identifier, for: IndexPath(item: index, section: section.rawValue)) as? BannerTableViewCell else {
            return UITableViewCell()
        }
//        cell.data.onNext()
        return cell
    }
}

enum TableSections: Int {
    case banner
}
