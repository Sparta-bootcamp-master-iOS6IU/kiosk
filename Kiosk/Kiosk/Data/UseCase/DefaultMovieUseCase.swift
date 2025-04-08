struct DefaultMovieUseCase: MovieUseCase {
    private let movieRepository: MovieRepository

    init(movieRepository: MovieRepository) {
        self.movieRepository = movieRepository
    }

    func fetchMovies(by sortedBy: String) -> [Movie] {
        movieRepository.fetchMovies(by: sortedBy)
    }
}
