//
//  PaymentDelegate.swift
//  Kiosk
//
//  Created by kingj on 4/10/25.
//

import Foundation

protocol PaymentDelegate: AnyObject {
    func deleteAllButtonDidTap()
    func payButtonDidTap()
}
