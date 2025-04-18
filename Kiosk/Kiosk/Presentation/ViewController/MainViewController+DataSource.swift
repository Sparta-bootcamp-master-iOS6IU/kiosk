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
        createSupplementaryViewProvider()
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
            cell?.delegate = self

            return cell

        case .cart:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CartCell.reuseIdentifier,
                for: indexPath
            ) as? CartCell

            guard case let .cart(ticket) = item else { return nil }

            cell?.delegate = self
            cell?.updateCell(ticket: ticket)

            return cell

        case .payment:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PaymentCell.reuseIdentifier,
                for: indexPath
            ) as? PaymentCell

            guard case let .payment(totalPrice, isEnabled) = item else { return nil }
            cell?.delegate = self
            cell?.showAlertAction()
            cell?.setTotalPrice(totalPrice)
            cell?.setButtonEnabled(isEnabled)
            return cell
        }
    }

    private func createSupplementaryViewProvider() {
        dataSource?.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
            guard let self else { return nil }
            switch kind {
            case UICollectionView.elementKindSectionHeader:
                let headerView = collectionView.dequeueReusableSupplementaryView(
                    ofKind: UICollectionView.elementKindSectionHeader,
                    withReuseIdentifier: SectionHeaderView.reuseIdentifier,
                    for: indexPath
                ) as? SectionHeaderView

                let totalCount = mainViewModel.totalCount()
                headerView?.updateTitle(totalCount: totalCount)

                return headerView

            case UICollectionView.elementKindSectionFooter:
                let footerView = collectionView.dequeueReusableSupplementaryView(
                    ofKind: UICollectionView.elementKindSectionFooter,
                    withReuseIdentifier: PageControlFooterView.reuseIdentifier,
                    for: indexPath
                ) as? PageControlFooterView

                footerView?.updateFooter(
                    currentPage: mainViewModel.currentMoviePage,
                    of: mainViewModel.movieList.count
                )

                return footerView

            default:
                return nil
            }
        }
    }

    private func applyInitialSnapshot() {
        var initialSnapshot = NSDiffableDataSourceSnapshot<MovieSection, MovieItem>()
        initialSnapshot.appendSections([.movieInfo, .cart, .payment])

        initialSnapshot.appendItems(mainViewModel.movieList.map { MovieItem.movieInfo($0) }, toSection: .movieInfo)
        initialSnapshot.appendItems(mainViewModel.ticketList.map { MovieItem.cart($0) }, toSection: .cart)
        initialSnapshot.appendItems([.payment(totalPrice: .zero, isEnable: false)], toSection: .payment)

        sections = initialSnapshot.sectionIdentifiers
        collectionView.sections = sections
        dataSource?.apply(initialSnapshot, animatingDifferences: true)
    }

    func updateSnapshot(with items: [MovieItem]) {
        guard var snapshot = dataSource?.snapshot() else { return }

        snapshot.deleteItems(snapshot.itemIdentifiers(inSection: .movieInfo))
        snapshot.appendItems(items, toSection: .movieInfo)

        dataSource?.apply(snapshot, animatingDifferences: true)
    }
}
