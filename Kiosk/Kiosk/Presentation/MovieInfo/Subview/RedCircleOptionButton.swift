//
//  RedCircleOptionButton.swift
//  Kiosk
//
//  Created by 곽다은 on 4/8/25.
//

import UIKit

import SnapKit
import Then

final class RedCircleOptionButton: UIButton {
    // MARK: - Properties

    private var optionTitle: String

    // MARK: - Init

    init(title: String) {
        optionTitle = title
        super.init(frame: .zero)

        setupUI()
    }

    required init?(coder _: NSCoder) {
        return nil
    }

    // MARK: - Methods

    private func setupUI() {
        setTitle(nil, for: .normal)

        configuration = makeConfiguration()
        configurationUpdateHandler = { [weak self] button in
            guard let self else { return }
            button.configuration = makeConfiguration()
        }

        addAction(UIAction(handler: { [weak self] _ in
            guard let self else { return }
            self.isSelected.toggle()
            self.setNeedsUpdateConfiguration()
        }), for: .touchUpInside)
    }

    private func makeConfiguration() -> UIButton.Configuration {
        var config = UIButton.Configuration.plain()
        let imageName = isSelected ? MovieInfoConstant.ButtonImageName.selectedImage
            : MovieInfoConstant.ButtonImageName.normalImage
        config.image = UIImage(named: imageName)
        config.imagePadding = MovieInfoConstant.Spacing.small
        config.attributedTitle = AttributedString(optionTitle, attributes: .init([
            .font: Common.FontStyle.buttonTitle,
            .foregroundColor: UIColor.kioskWhite,
        ]))
        config.baseBackgroundColor = .clear
        config.contentInsets = .zero
        return config
    }
}
