final class MainViewModel {
    // MARK: - Properties

    typealias Delegate = CartDelegate
    weak var delegate: Delegate?

    private let ticketCountUseCase: TicketCountUseCase
    private let ticketPriceUseCase: TicketPriceUseCase

    var onTotalPriceChanged: ((Int) -> Void)?

    private(set) var ticketList: [Ticket] = [] {
        didSet {
            updateTotalPrice()
        }
    }

    private(set) var totalPrice: Int = 0 {
        didSet {
            onTotalPriceChanged?(totalPrice)
        }
    }

    // MARK: - init

    init(ticketCountUseCase: TicketCountUseCase, ticketPriceUseCase: TicketPriceUseCase) {
        self.ticketCountUseCase = ticketCountUseCase
        self.ticketPriceUseCase = ticketPriceUseCase
    }

    // MARK: - Methods

    func updateTotalPrice() {
        var sum = 0
        for ticket in ticketList {
            let price = ticket.discountedPrice ?? ticket.originalPrice
            sum += price * ticket.count
        }
        totalPrice = sum
    }

    func removeTicketList() {
        ticketList.removeAll()
    }

    func changeCount(of ticket: Ticket, by delta: Int) {
        let result = ticketCountUseCase.changeCount(of: ticket, delta: delta)

        switch result {
        case let .success(updated):
            changePrice(of: updated)

            delegate?.didChangeTicket()
            updateTotalPrice()

        case .failure(.exceed):
            delegate?.didExceedMaxCount()

        case .failure(.zero):
            delegate?.didReachZeroCount(ticket)
        }
    }

    private func changePrice(of ticket: Ticket) {
        let updated = ticketPriceUseCase.changePrice(of: ticket)

        change(ticket: updated)
    }

    private func change(ticket: Ticket) {
        if let index = findIndex(of: ticket) {
            ticketList[index] = ticket
        }
    }

    func remove(ticket: Ticket) {
        if let index = findIndex(of: ticket) {
            ticketList.remove(at: index)
        }
    }

    private func findIndex(of ticket: Ticket) -> Int? {
        ticketList.firstIndex { $0.movieId == ticket.movieId && $0.discountCategory == ticket.discountCategory }
    }

    func totalCount() -> Int {
        ticketList.reduce(0) { $0 + $1.count }
    }
}
