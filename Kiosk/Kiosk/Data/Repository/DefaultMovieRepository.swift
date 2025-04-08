struct DefaultMovieRepository: MovieRepository {
    private let movieDataSource: MovieDataSource

    init(movieDataSource: MovieDataSource) {
        self.movieDataSource = movieDataSource
    }

    func fetchMovies(by sortedBy: String) -> [Movie] {
        movieDataSource.fetchMovies(by: sortedBy)
    }
}
