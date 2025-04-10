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

        // TODO: viewModel의 옵션 상태 가져와서 option에 할당
        mainViewModel.addTicket(of: movie, option: nil)
    }

    func didTapSeniorButton() {
        mainViewModel.toggleOptionButton(option: .senior)
    }

    func didTapDisabledButton() {
        mainViewModel.toggleOptionButton(option: .disabled)
    }
}
