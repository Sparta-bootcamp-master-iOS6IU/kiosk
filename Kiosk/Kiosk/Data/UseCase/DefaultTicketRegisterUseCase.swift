//
//  DefaultTicketRegisterUseCase.swift
//  Kiosk
//
//  Created by 곽다은 on 4/10/25.
//

struct DefaultTicketRegisterUseCase: TicketRegisterUseCase {
    func register(from movie: Movie, option: BenefitOption? = nil, ticketList: [Ticket]) -> Result<Ticket, RegisterTicketError> {
        let isDuplicateTicket = ticketList.contains(where: {
            $0.movieId == movie.id && $0.discountCategory == option
        })

        if isDuplicateTicket {
            return .failure(RegisterTicketError.duplicateTicket)
        }

        let newTicket = converToTicket(from: movie, option: option)
        return .success(newTicket)
    }

    private func converToTicket(from movie: Movie, option: BenefitOption?) -> Ticket {
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
            totalOriginalPrice: String(movie.price),
            discountedPrice: discountedPrice,
            discountCategory: option,
            count: 1
        )

        return ticket
    }
}
