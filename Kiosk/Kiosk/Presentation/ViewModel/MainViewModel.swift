final class MainViewModel {
    // MARK: - Properties

    typealias Delegate = CartDelegate
    weak var delegate: Delegate?

    private let ticketCountUseCase: TicketCountUseCase
    private let ticketPriceUseCase: TicketPriceUseCase
    private let ticketRegisterUseCase: TicketRegisterUseCase
    private let movieUseCase: MovieUseCase

    var onPaymentCellDataChanged: ((Int, Bool) -> Void)?

    private(set) var ticketList: [Ticket] = [] {
        didSet {
            let totalPrice = updateTotalPrice()
            let isEnabled = setButtonEnabled(basedOn: ticketList.count)
            onPaymentCellDataChanged?(totalPrice, isEnabled)
        }
    }

    private(set) var movieList: [Movie] = []

    private(set) var currentMoviePage = 0 {
        didSet {
            selectedOption = nil
            delegate?.didChangeCurrentPage(page: currentMoviePage, of: movieList.count)
        }
    }

    var selectedOption: BenefitOption?

    // MARK: - Init

    init(
        ticketCountUseCase: TicketCountUseCase,
        ticketPriceUseCase: TicketPriceUseCase,
        ticketRegisterUseCase: TicketRegisterUseCase,
        movieUseCase: MovieUseCase
    ) {
        self.ticketCountUseCase = ticketCountUseCase
        self.ticketPriceUseCase = ticketPriceUseCase
        self.ticketRegisterUseCase = ticketRegisterUseCase
        self.movieUseCase = movieUseCase
    }

    // MARK: - Methods

    private func setButtonEnabled(basedOn listCount: Int) -> Bool {
        return listCount == 0 ? false : true
    }

    private func updateTotalPrice() -> Int {
        var totalPrice = 0
        for ticket in ticketList {
            let price = ticket.discountedPrice ?? ticket.originalPrice
            totalPrice += price * ticket.count
        }
        return totalPrice
    }

    func changeCurrentPage(newPage: Int) {
        if newPage != currentMoviePage {
            currentMoviePage = newPage
        }
    }

    func getMovie(at index: Int) -> Movie {
        movieList[index]
    }

    func addTicket(of movie: Movie, option: BenefitOption?) {
        let result = ticketRegisterUseCase.register(from: movie, option: option, ticketList: ticketList)

        switch result {
        case let .success(newTicket):
            let formattedTicket = ticketPriceUseCase.changePrice(of: newTicket)
            ticketList.append(formattedTicket)
            delegate?.didAddTicket(formattedTicket)
        case .failure:
            delegate?.didAddDuplicatedTicket()
        }
    }

    func toggleOptionButton(option: BenefitOption) {
        if selectedOption == option {
            selectedOption = nil
        } else {
            selectedOption = option
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

    func fetchMovies(by sorting: SortingOption) {
        movieList = movieUseCase.fetchMovies(by: sorting)
    }
}
