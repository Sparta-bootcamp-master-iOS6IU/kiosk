//
//  DefaultTicketUseCase.swift
//  Kiosk
//
//  Created by 곽다은 on 4/10/25.
//

struct DefaultTicketUseCase: TicketUseCase {
    func convertToTicket(from movie: Movie, option: BenefitOption? = nil) -> Ticket {
        let discountedPrice: Int?
        switch option {
        case .senior: discountedPrice = movie.seniorPrice
        case .disabled: discountedPrice = movie.disabledPrice
        default: discountedPrice = nil
        }

        let ticket = Ticket(
            movieId: movie.id,
            title: movie.title,
            originalPrice: movie.price,
            totalOriginalPrice: "",
            discountedPrice: discountedPrice,
            discountCategory: option,
            count: 1
        )

        return ticket
    }
}
