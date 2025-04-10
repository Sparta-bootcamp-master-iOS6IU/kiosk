//
//  PaymentCellDelegate.swift
//  Kiosk
//
//  Created by kingj on 4/10/25.
//

import UIKit

protocol PaymentCellDelegate: AnyObject {
    func deleteAllButtonDidTap()
    func payButtonDidTap()
    func showAlert(alert: UIAlertController)
}
