final class AppDIContainer {
    let dataSourceDIContainer = DataSourceDIContainer()
    lazy var repositoryDIContainer = RepositoryDIContainer(dataSourceDIContainer: dataSourceDIContainer)
    lazy var useCaseDIContainer = UseCaseDIContainer(repositoryDIContainer: repositoryDIContainer)

    func makeMainViewModel() -> MainViewModel {
        MainViewModel(ticketCountUseCase: useCaseDIContainer.makeTicketCountUseCase())
    }

    func makeMainViewController() -> MainViewController {
        MainViewController(mainViewModel: makeMainViewModel())
    }
}
