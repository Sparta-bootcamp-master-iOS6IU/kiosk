import Foundation
import UIKit

final class MainViewModel {
    // MARK: - Properties

    typealias Delegate = CartDelegate
    weak var delegate: Delegate?

    private let ticketCountUseCase: TicketCountUseCase
    private(set) var ticketList: [Ticket] = []

    // MARK: - init

    init(ticketCountUseCase: TicketCountUseCase) {
        self.ticketCountUseCase = ticketCountUseCase
    }

    // MARK: - Methods

    func removeTicketList() {
        ticketList.removeAll()
    }

    func changeCount(of ticket: Ticket, by delta: Int) {
        let result = ticketCountUseCase.changeCount(of: ticket, delta: delta)

        switch result {
        case let .success(ticket):
            if let index = ticketList.firstIndex(where: {
                $0.movieId == ticket.movieId && $0.discountCategory == ticket.discountCategory
            }) {
                ticketList[index] = ticket
            }

            delegate?.didChangeTicket(ticket)
        case .failure(.exceed):
            delegate?.didExceedMaxCount()
        case .failure(.zero):
            delegate?.didReachZeroCount(ticket)
        }
    }
}
