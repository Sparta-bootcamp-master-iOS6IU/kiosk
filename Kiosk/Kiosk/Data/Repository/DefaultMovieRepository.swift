struct DefaultMovieRepository: MovieRepository {
    private let movieDataSource: MovieDataSource

    init(movieDataSource: MovieDataSource) {
        self.movieDataSource = movieDataSource
    }

    func fetchMovies(by sorting: SortingOption) -> [Movie] {
        movieDataSource.fetchMovies(by: sorting)
    }
}
