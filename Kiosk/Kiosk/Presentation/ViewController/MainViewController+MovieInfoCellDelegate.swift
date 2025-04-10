//
//  MainViewController+MovieInfoCellDelegate.swift
//  Kiosk
//
//  Created by 곽다은 on 4/10/25.
//

import Foundation

extension MainViewController: MovieInfoCellDelegate {
    func didTapAddButton(in cell: MovieInfoCell) {
        if let indexPath = collectionView.collectionView.indexPath(for: cell) {
            let movieIndex = indexPath.item

            let movie = mainViewModel.getMovie(at: movieIndex)
            mainViewModel.addTicket(of: movie, option: nil)
        }
    }
}
