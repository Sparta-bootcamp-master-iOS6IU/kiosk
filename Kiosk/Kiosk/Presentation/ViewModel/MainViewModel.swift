final class MainViewModel {
    // MARK: - Properties

    typealias Delegate = CartDelegate
    weak var delegate: Delegate?

    private let ticketCountUseCase: TicketCountUseCase
    private let ticketPriceUseCase: TicketPriceUseCase
    private let ticketRegisterUseCase: TicketRegisterUseCase

    // TODO: 티켓 더미 데이터(데이터 연결 후 삭제)
    private(set) var ticketList: [Ticket] = [
        Ticket(
            movieId: "00001",
            title: "보헤미안 랩소디",
            originalPrice: 14000,
            totalOriginalPrice: "₩14,000",
            discountedPrice: 6000,
            totalDiscountedPrice: "₩6,000",
            discountCategory: .disabled,
            count: 1
        ),
        Ticket(
            movieId: "00002",
            title: "보헤미안 랩소디2",
            originalPrice: 15000,
            totalOriginalPrice: "₩15,000",
            discountedPrice: 4000,
            totalDiscountedPrice: "₩4,000",
            discountCategory: .senior,
            count: 1
        ),
        Ticket(
            movieId: "00003",
            title: "보헤미안 랩소디3",
            originalPrice: 16000,
            totalOriginalPrice: "₩16,000",
            discountedPrice: .none,
            totalDiscountedPrice: .none,
            discountCategory: .none,
            count: 1
        ),
    ]

    // TODO: movieUsecase로 fetch
    private let movieList: [Movie] = Movie.sampleData

    private var ticket: Ticket?

    // MARK: - Init

    init(
        ticketCountUseCase: TicketCountUseCase,
        ticketPriceUseCase: TicketPriceUseCase,
        ticketRegisterUseCase: TicketRegisterUseCase
    ) {
        self.ticketCountUseCase = ticketCountUseCase
        self.ticketPriceUseCase = ticketPriceUseCase
        self.ticketRegisterUseCase = ticketRegisterUseCase
    }

    // MARK: - Methods

    func getMovie(at index: Int) -> Movie {
        movieList[index]
    }

    func addTicket(of movie: Movie, option _: BenefitOption?) {
        let result = ticketRegisterUseCase.register(from: movie, option: nil, ticketList: ticketList)

        switch result {
        case let .success(newTicket):
            let formattedTicket = ticketPriceUseCase.changePrice(of: newTicket)
            ticketList.append(formattedTicket)
            delegate?.didAddTicket(formattedTicket)
        case .failure:
            delegate?.didAddDuplicatedTicket()
        }
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
