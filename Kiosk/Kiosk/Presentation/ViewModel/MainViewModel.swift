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

    // MARK: - Methods
    
    func deleteAllButtonDidTap() {
        deleteAllTickets()
    }

    private func deleteAllTickets() {
        ticketList.removeAll()
    }
}
