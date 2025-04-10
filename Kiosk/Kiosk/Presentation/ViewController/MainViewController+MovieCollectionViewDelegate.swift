//
//  MainViewController+MovieCollectionViewDelegate.swift
//  Kiosk
//
//  Created by 곽다은 on 4/10/25.
//

extension MainViewController: MovieCollectionViewDelegate {
    func didChangeCurrentPage(_ page: Int) {
        mainViewModel.changeCurrentPage(newPage: page)
    }
}
