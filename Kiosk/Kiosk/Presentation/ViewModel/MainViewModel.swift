final class MainViewModel {
    typealias Delegate = CartDelegate
    weak var delegate: Delegate?

    private let ticketCountUseCase: TicketCountUseCase

    private var ticket: Ticket?

    init(ticketCountUseCase: TicketCountUseCase) {
        self.ticketCountUseCase = ticketCountUseCase
    }

    func changeCount(by delta: Int) {
        guard let ticket = ticket else { return }

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
