final class AppDIContainer {
    let dataSourceDIContainer = DataSourceDIContainer()
    lazy var repositoryDIContainer = RepositoryDIContainer(dataSourceDIContainer: dataSourceDIContainer)
    lazy var useCaseDIContainer = UseCaseDIContainer(repositoryDIContainer: repositoryDIContainer)

    func makeMainViewModel() -> MainViewModel {
        MainViewModel(
            ticketCountUseCase: useCaseDIContainer.makeTicketCountUseCase(),

            ticketPriceUseCase: useCaseDIContainer.makeTicketPriceUseCase(),

            ticketUseCase: useCaseDIContainer.makeTicketUseCase()
        )
    }

    func makeMainViewController() -> MainViewController {
        MainViewController(mainViewModel: makeMainViewModel())
    }
}
