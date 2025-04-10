//
//  PageControlFooterView.swift
//  Kiosk
//
//  Created by 곽다은 on 4/9/25.
//

import UIKit

import SnapKit
import Then

final class PageControlFooterView: UICollectionReusableView, ReuseIdentifying {
    // MARK: - Components

    let smallDot = UIImage(named: MovieInfoConstant.PageControlImageName.defaultPage)
    let largeDot = UIImage(named: MovieInfoConstant.PageControlImageName.currentPage)

    private let pageControl = UIPageControl().then {
        $0.pageIndicatorTintColor = .kioskGray2
        $0.currentPageIndicatorTintColor = .kioskRed
        $0.currentPage = 0
        $0.isUserInteractionEnabled = false
    }

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - Methods

    private func configureUI() {
        addSubview(pageControl)

        pageControl.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Common.Config.defaultSpacing)
            $0.centerX.equalToSuperview()
        }
    }

    func updateFooter() {
        // TODO: 동적으로 업데이트
        pageControl.numberOfPages = 5
        pageControl.preferredIndicatorImage = smallDot

        for number in 0 ..< 5 {
            let image = (number == pageControl.currentPage) ? largeDot : smallDot
            pageControl.setIndicatorImage(image, forPage: number)
        }
    }
}
