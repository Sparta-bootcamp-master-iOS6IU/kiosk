struct DataSourceDIContainer {
    func makeMovieDataSource() -> MovieDataSource {
        DefaultMovieDataSource()
    }
}
