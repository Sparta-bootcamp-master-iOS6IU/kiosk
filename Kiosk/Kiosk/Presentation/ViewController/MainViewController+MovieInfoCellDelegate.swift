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

        mainViewModel.addTicket(of: movie, option: mainViewModel.selectedOption)
    }

    func didSelectedBenefit(_ option: BenefitOption) {
        mainViewModel.toggleOptionButton(option: option)
    }
}
