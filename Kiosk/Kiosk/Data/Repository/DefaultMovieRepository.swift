struct DefaultMovieRepository: MovieRepository {
    private let movieDataSource: MovieDataSource

    init(movieDataSource: MovieDataSource) {
        self.movieDataSource = movieDataSource
    }

    func fetchMovies(by sorting: String) -> [Movie] {
        movieDataSource.fetchMovies(by: sorting)
    }
}
