protocol MovieUseCase {
    func fetchMovies(by sortedBy: String) -> [Movie]
}
