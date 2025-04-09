//
//  MainViewModel.swift
//  Kiosk
//
//  Created by kingj on 4/10/25.
//

import Foundation
import UIKit

final class MainViewModel: PaymentDelegate {
    // MARK: - Properties

    private var ticketList: [Ticket] = []
    var showPaymentCompleteAlert: (() -> Void)?

    // MARK: - Methods

    func deleteAllButtonDidTap() {
        deleteAllTickets()
    }
    
    func payButtonDidTap() {
        DispatchQueue.main.asyncAfter(deadline: Payment.CompleteAlert.delayTime) {
            self.showPaymentCompleteAlert?()
        }
        deleteAllTickets()
    }
    
    private func deleteAllTickets() {
        ticketList.removeAll()
    }
}
