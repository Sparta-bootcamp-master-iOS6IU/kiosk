import Foundation
import UIKit

final class MainViewModel {
    // MARK: - Properties

    typealias Delegate = CartDelegate
    weak var delegate: Delegate?

    private let ticketCountUseCase: TicketCountUseCase

    private var ticket: Ticket?

    private var ticketList: [Ticket] = []

    // MARK: - init

    init(ticketCountUseCase: TicketCountUseCase) {
        self.ticketCountUseCase = ticketCountUseCase
    }

    // MARK: - Methods

    func removeTicketList() {
        ticketList.removeAll()
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
