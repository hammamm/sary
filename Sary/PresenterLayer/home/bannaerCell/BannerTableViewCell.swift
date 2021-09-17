//
//  BannerTableViewCell.swift
//  Sary
//
//  Created by hammam abdulaziz on 10/02/1443 AH.
//

import UIKit
import RxSwift
import RxCocoa

class BannerTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    static let identifier = "BannerTableViewCell"
    
    var data: PublishSubject<[Banner]> = PublishSubject()
    let disposeBag = DisposeBag()

    override func awakeFromNib() {
        super.awakeFromNib()
        configuration()
    }
    
    private func configuration()  {
        collectionView.register(UINib(nibName: ImageCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
        self.data.bind(to: collectionView.rx.items(cellIdentifier: ImageCollectionViewCell.identifier, cellType: ImageCollectionViewCell.self)) { row, data, cell in
            cell.image = data.link
        }.disposed(by: disposeBag)
    }
}
