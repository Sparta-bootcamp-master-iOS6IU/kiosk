import Foundation
import UIKit

final class MainViewModel {
    // MARK: - Properties

    typealias Delegate = CartDelegate
    weak var delegate: Delegate?

    private let ticketCountUseCase: TicketCountUseCase

    // TODO: 티켓 더미 데이터(데이터 연결 후 삭제)
    private(set) var ticketList: [Ticket] = [
        Ticket(
            movieId: "00001",
            title: "보헤미안 랩소디",
            originalPrice: 14000,
            discountedPrice: 6000,
            discountCategory: .disabled,
            count: 1
        ),
        Ticket(
            movieId: "00002",
            title: "보헤미안 랩소디2",
            originalPrice: 14000,
            discountedPrice: 6000,
            discountCategory: .disabled,
            count: 1
        ),
    ]

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
        case let .success(updated):
            if let index = findIndex(of: updated) {
                ticketList[index] = updated
            }

            delegate?.didChangeTicket(updated)
        case .failure(.exceed):
            delegate?.didExceedMaxCount()
        case .failure(.zero):
            if let index = findIndex(of: ticket) {
                ticketList.remove(at: index)
            }

            delegate?.didReachZeroCount(ticket)
        }
    }

    private func findIndex(of ticket: Ticket) -> Int? {
        ticketList.firstIndex { $0.movieId == ticket.movieId && $0.discountCategory == ticket.discountCategory }
    }
}
