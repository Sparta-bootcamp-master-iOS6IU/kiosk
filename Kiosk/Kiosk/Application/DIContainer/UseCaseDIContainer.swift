struct UseCaseDIContainer {
    private let repositoryDIContainer: RepositoryDIContainer

    init(repositoryDIContainer: RepositoryDIContainer) {
        self.repositoryDIContainer = repositoryDIContainer
    }

    func makeMovieUseCase() -> MovieUseCase {
        DefaultMovieUseCase(movieRepository: repositoryDIContainer.makeMovieRepository())
    }

    func makeTicketCountUseCase() -> TicketCountUseCase {
        DefaultTicketCountUseCase()
    }

    func makeTicketPriceUseCase() -> TicketPriceUseCase {
        DefaultTicketPriceUseCase()
    }

    func makeTicketRegisterUseCase() -> TicketRegisterUseCase {
        DefaultTicketRegisterUseCase()
    }
}
