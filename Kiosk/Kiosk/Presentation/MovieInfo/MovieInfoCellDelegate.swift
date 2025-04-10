//
//  MovieInfoCellDelegate.swift
//  Kiosk
//
//  Created by 곽다은 on 4/10/25.
//

protocol MovieInfoCellDelegate: AnyObject {
    func didTapAddButton(in cell: MovieInfoCell)
    func didTapSeniorButton()
    func didTapDisabledButton()
}
