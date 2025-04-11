struct RepositoryDIContainer {
    private let dataSourceDIContainer: DataSourceDIContainer

    init(dataSourceDIContainer: DataSourceDIContainer) {
        self.dataSourceDIContainer = dataSourceDIContainer
    }

    func makeMovieRepository() -> MovieRepository {
        DefaultMovieRepository(movieDataSource: dataSourceDIContainer.makeMovieDataSource())
    }
}
