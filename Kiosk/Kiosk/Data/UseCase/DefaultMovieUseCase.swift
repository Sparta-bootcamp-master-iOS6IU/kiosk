struct DefaultMovieUseCase: MovieUseCase {
    private let movieRepository: MovieRepository

    init(movieRepository: MovieRepository) {
        self.movieRepository = movieRepository
    }

    func fetchMovies(by sorting: String) -> [Movie] {
        movieRepository.fetchMovies(by: sorting)
    }
}
