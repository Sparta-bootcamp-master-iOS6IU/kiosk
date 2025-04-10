//
//  MovieInfoCell+RedCircleOptionButtonDelegate.swift
//  Kiosk
//
//  Created by 곽다은 on 4/10/25.
//

extension MovieInfoCell: RedCircleOptionButtonDelegate {
    func didTapButton(title: String) {
        guard let option = BenefitOption(rawValue: title) else { return }
        delegate?.didSelectedBenefit(option)
        setSelectedOption(option)
    }
}
