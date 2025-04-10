//
//  MovieInfoCell+RedCircleOptionButtonDelegate.swift
//  Kiosk
//
//  Created by 곽다은 on 4/10/25.
//

extension MovieInfoCell: RedCircleOptionButtonDelegate {
    func didTapButton(title: String) {
        guard let option = BenefitOption(rawValue: title) else { return }
        switch option {
        case .senior:
            delegate?.didTapSeniorButton()
        case .disabled:
            delegate?.didTapDisabledButton()
        }
    }
}
