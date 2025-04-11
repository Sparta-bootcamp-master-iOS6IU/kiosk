struct DefaultMovieUseCase: MovieUseCase {
    private let movieRepository: MovieRepository

    init(movieRepository: MovieRepository) {
        self.movieRepository = movieRepository
    }

    func fetchMovies(by sorting: SortingOption) -> [Movie] {
        movieRepository.fetchMovies(by: sorting)
    }
}
