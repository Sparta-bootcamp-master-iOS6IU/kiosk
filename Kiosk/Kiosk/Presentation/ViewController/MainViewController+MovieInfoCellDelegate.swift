//
//  MainViewController+MovieInfoCellDelegate.swift
//  Kiosk
//
//  Created by 곽다은 on 4/10/25.
//

import Foundation

extension MainViewController: MovieInfoCellDelegate {
    func didTapAddButton(in cell: MovieInfoCell) {
        guard let indexPath = collectionView.collectionView.indexPath(for: cell) else {
            return
        }

        let movieIndex = indexPath.item
        let movie = mainViewModel.getMovie(at: movieIndex)

        var option: BenefitOption?
        if mainViewModel.isSeniorButtonSelected {
            option = .senior
        } else if mainViewModel.isDisabledButtonSelected {
            option = .disabled
        }

        mainViewModel.addTicket(of: movie, option: option)
    }

    func didTapSeniorButton() {
        mainViewModel.toggleOptionButton(option: .senior)
    }

    func didTapDisabledButton() {
        mainViewModel.toggleOptionButton(option: .disabled)
    }
}
