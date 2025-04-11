//
//  TitleContentView.swift
//  Kiosk
//
//  Created by 곽다은 on 4/8/25.
//

import SnapKit
import Then
import UIKit

final class TitleContentView: UIView {
    // MARK: - Components

    private let stackView = UIStackView().then {
        $0.spacing = MovieInfoConstant.Spacing.extraSmall
        $0.alignment = .leading
        $0.distribution = .fill
    }

    private let titleLabel = UILabel().then {
        $0.textColor = .kioskWhite
        $0.font = Common.FontStyle.contentTitle
        $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        $0.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
    }

    private let contentLabel = UILabel().then {
        $0.textColor = .kioskGray1
        $0.font = Common.FontStyle.content2
        $0.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    }

    // MARK: - Init

    init(title: String, axis: NSLayoutConstraint.Axis, contentNumberOfLines: Int) {
        super.init(frame: .zero)

        titleLabel.text = title
        contentLabel.numberOfLines = contentNumberOfLines
        stackView.axis = axis
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods

    private func setupUI() {
        addSubview(stackView)
        [titleLabel, contentLabel]
            .forEach { stackView.addArrangedSubview($0) }

        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    func setContent(_ content: String) {
        contentLabel.text = content
    }
}
