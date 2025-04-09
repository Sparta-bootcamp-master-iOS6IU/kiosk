//
//  MainViewController+DataSource.swift
//  Kiosk
//
//  Created by 곽다은 on 4/9/25.
//

import UIKit

extension MainViewController {
    private typealias DataSource = UICollectionViewDiffableDataSource

    // DataSource 생성, 초기 스냅샷을 적용
    func configureDataSource() {
        dataSource = createDataSource()
        applyInitialSnapshot()
    }

    // 컬렉션 뷰의 DataSource를 생성해 반환
    // 셀을 어떻게 구성할지 cellProvider를 구현
    private func createDataSource() -> DataSource<MovieSection, MovieItem> {
        let dataSource = DataSource<MovieSection, MovieItem>(
            collectionView: collectionView.collectionView
        ) { [weak self] collectionView, indexPath, item in
            self?.makeCell(collectionView, indexPath, item)
        }
        return dataSource
    }

    // indexPath와 item 정보에 따라 알맞은 셀을 생성/반환
    private func makeCell(
        _ collectionView: UICollectionView,
        _ indexPath: IndexPath,
        _ item: MovieItem
    ) -> UICollectionViewCell? {
        let section = sections[indexPath.section]

        switch section {
        case .movieInfo:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: MovieInfoCell.reuseIdentifier,
                for: indexPath
            ) as? MovieInfoCell

            guard case let .movieInfo(movie) = item else { return nil }
            cell?.updateCell(movie: movie)

            return cell

        case .cart:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CartCell.reuseIdentifier,
                for: indexPath
            ) as? CartCell

            // TODO: 레이아웃 확인용, 데이터 연결 후 삭제
            cell?.updateCell(title: "dsad",
                             originalPrice: "dsad",
                             discountedPrice: "sda",
                             benefitOption: "dsadsa",
                             count: "asd")

            return cell

        case .payment:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PaymentCell.reuseIdentifier,
                for: indexPath
            ) as? PaymentCell

            return cell
        }
    }

    private func applyInitialSnapshot() {
        var initialSnapshot = NSDiffableDataSourceSnapshot<MovieSection, MovieItem>()
        initialSnapshot.appendSections([.movieInfo, .cart, .payment])

        // TODO: 레이아웃 확인용, 데이터 연결 후 삭제
        initialSnapshot.appendItems(Movie.sampleData.map { MovieItem.movieInfo($0) }, toSection: .movieInfo)
        initialSnapshot.appendItems([.cart], toSection: .cart)
        initialSnapshot.appendItems([.payment], toSection: .payment)

        sections = initialSnapshot.sectionIdentifiers
        collectionView.sections = sections
        dataSource?.apply(initialSnapshot, animatingDifferences: true)
    }
}
