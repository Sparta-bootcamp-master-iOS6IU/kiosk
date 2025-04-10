//
//  TicketRegisterUseCase.swift
//  Kiosk
//
//  Created by 곽다은 on 4/10/25.
//

protocol TicketRegisterUseCase {
    func register(from movie: Movie, option: BenefitOption?, ticketList: [Ticket]) -> Result<Ticket, RegisterTicketError>
}
