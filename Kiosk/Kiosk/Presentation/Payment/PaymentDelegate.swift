//
//  PaymentDelegate.swift
//  Kiosk
//
//  Created by kingj on 4/10/25.
//

import UIKit

protocol PaymentDelegate: AnyObject {
    func deleteAllButtonDidTap()
    func showAlert(alert: UIAlertController)
}
