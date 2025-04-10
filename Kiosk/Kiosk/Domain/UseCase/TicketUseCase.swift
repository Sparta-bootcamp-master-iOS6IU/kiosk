//
//  TicketUseCase.swift
//  Kiosk
//
//  Created by 곽다은 on 4/10/25.
//

protocol TicketUseCase {
    func convertToTicket(from movie: Movie, option: BenefitOption?) -> Ticket
}
