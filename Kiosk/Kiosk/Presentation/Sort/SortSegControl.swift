//
//  SortSegControl.swift
//  Kiosk
//
//  Created by kingj on 4/8/25.
//

import UIKit

final class SortSegControl: UISegmentedControl {
    weak var delegate: SortSegControlDelegate?

    // MARK: - Init

    override init(items: [Any]?) {
        super.init(items: items)
        configureSegmentedControl()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods

    private func configureSegmentedControl() {
        selectedSegmentIndex = .zero
        selectedSegmentTintColor = .kioskBlue
        clipsToBounds = true
        setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.kioskWhite,
            NSAttributedString.Key.font: Common.FontStyle.buttonTitle,
        ], for: .normal)
        setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.kioskWhite,
            NSAttributedString.Key.font: Common.FontStyle.buttonTitle,
        ], for: .selected)
        setDividerImage(UIImage(), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)

        addTarget(self, action: #selector(sortSegmentedChanged(_:)), for: .valueChanged)
    }

    @objc private func sortSegmentedChanged(_ sender: UISegmentedControl) {
        let selectedIndex = sender.selectedSegmentIndex

        guard let sorting = SortingOption(rawValue: selectedIndex) else {
            return
        }
        delegate?.sortSegmentChanged(by: sorting)
    }
}
