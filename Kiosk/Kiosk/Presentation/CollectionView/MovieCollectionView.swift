//
//  MovieCollectionView.swift
//  Kiosk
//
//  Created by 곽다은 on 4/8/25.
//

import Foundation
import UIKit

import SnapKit
import Then

final class MovieCollectionView: UIView {
    private typealias MovieCell = MovieInfoCell
    private typealias Dimension = CollectionViewConstant.Dimension
    private typealias Spacing = CollectionViewConstant.Spacing
    private typealias Inset = CollectionViewConstant.Inset

    // MARK: - Properties

    weak var delegate: MovieCollectionViewDelegate?
    var sections: [MovieSection]?

    // MARK: - Components

    lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: createLayout()
    ).then {
        $0.backgroundColor = .black
        $0.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.reuseIdentifier)
        $0.register(CartCell.self, forCellWithReuseIdentifier: CartCell.reuseIdentifier)
        $0.register(PaymentCell.self, forCellWithReuseIdentifier: PaymentCell.reuseIdentifier)

        $0.register(
            SectionHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: SectionHeaderView.reuseIdentifier
        )
        $0.register(
            PageControlFooterView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: PageControlFooterView.reuseIdentifier
        )
    }

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupAddView()
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods

    private func setupAddView() {
        addSubview(collectionView)
    }

    private func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension MovieCollectionView {
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { [weak self] sectionIndex, _
            -> NSCollectionLayoutSection? in
            guard let self, let sections else { return nil }

            let section = sections[sectionIndex]
            switch section {
            case .movieInfo:
                let footerItem = createFooterItem()
                return createMovieInfoSection(supplementaryItems: [footerItem])
            case .cart:
                let headerItem = createHeaderItem()
                return createCartSection(supplementaryItems: [headerItem])
            case .payment:
                return createPaymentSection()
            }
        }
        return layout
    }

    private func createHeaderItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(Dimension.defaultWidth),
            heightDimension: .absolute(Dimension.supplementaryHeight + Common.Config.defaultSpacing * 2)
        )

        let headerItem = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        headerItem.contentInsets = .init(
            top: Common.Config.defaultSpacing,
            leading: Common.Config.defaultSpacing,
            bottom: Common.Config.defaultSpacing,
            trailing: .zero
        )

        return headerItem
    }

    private func createFooterItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        let footerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(Dimension.defaultWidth),
            heightDimension: .absolute(Dimension.supplementaryHeight * 3)
        )

        let footerItem = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: footerSize,
            elementKind: UICollectionView.elementKindSectionFooter,
            alignment: .bottom
        )

        return footerItem
    }

    private func createMovieInfoSection(supplementaryItems: [NSCollectionLayoutBoundarySupplementaryItem])
        -> NSCollectionLayoutSection
    {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(Dimension.defaultWidth),
            heightDimension: .absolute(Dimension.movieHeight)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(Dimension.movieGroupWidth),
            heightDimension: .absolute(Dimension.movieHeight)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(
            top: .zero,
            leading: Common.Config.defaultSpacing,
            bottom: .zero,
            trailing: Common.Config.defaultSpacing
        )
        section.interGroupSpacing = Spacing.interGroup
        section.orthogonalScrollingBehavior = .groupPagingCentered
        section.boundarySupplementaryItems = supplementaryItems
        section.visibleItemsInvalidationHandler = { [weak self] _, offset, env in
            let currentPage = Int(max(0, round(offset.x / env.container.contentSize.width)))
            self?.delegate?.didChangeCurrentPage(currentPage)
        }

        return section
    }

    private func createCartSection(
        supplementaryItems: [NSCollectionLayoutBoundarySupplementaryItem])
        -> NSCollectionLayoutSection
    {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(Dimension.defaultWidth),
            heightDimension: .estimated(Dimension.estimatedHeight)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(Dimension.defaultWidth),
            heightDimension: .estimated(Dimension.estimatedHeight)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(
            top: .zero,
            leading: Common.Config.defaultSpacing,
            bottom: Inset.sectionBottom,
            trailing: Common.Config.defaultSpacing
        )
        section.boundarySupplementaryItems = supplementaryItems

        return section
    }

    private func createPaymentSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(Dimension.defaultWidth),
            heightDimension: .estimated(Dimension.estimatedHeight)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(Dimension.defaultWidth),
            heightDimension: .estimated(Dimension.estimatedHeight)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(
            top: Inset.sectionTop,
            leading: Common.Config.defaultSpacing,
            bottom: Inset.sectionBottom,
            trailing: Common.Config.defaultSpacing
        )

        return section
    }
}
