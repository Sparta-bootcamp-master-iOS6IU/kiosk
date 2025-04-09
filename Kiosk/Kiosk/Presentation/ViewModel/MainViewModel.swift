final class MainViewModel {
    typealias Delegate = CartDelegate
    weak var delegate: Delegate?

    private let ticketCountUseCase: TicketCountUseCase

    init(ticketCountUseCase: TicketCountUseCase) {
        self.ticketCountUseCase = ticketCountUseCase
    }

    func changeCount(of ticket: Ticket, delta: Int) {
        let result = ticketCountUseCase.changeCount(of: ticket, delta: delta)

        switch result {
        case let .success(ticket):
            delegate?.didChangeTicket(ticket)
        case .failure(.exceed):
            delegate?.didExceedMaxCount()
        case .failure(.zero):
            delegate?.didReachZeroCount(ticket)
        }
    }
}
