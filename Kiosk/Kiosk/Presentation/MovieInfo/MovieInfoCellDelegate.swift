//
//  MovieInfoCellDelegate.swift
//  Kiosk
//
//  Created by 곽다은 on 4/10/25.
//

import Foundation

protocol MovieInfoCellDelegate: AnyObject {
    func didTapAddButton(in cell: MovieInfoCell)
}
