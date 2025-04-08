protocol MovieUseCase {
    func fetchMovies(by sorting: String) -> [Movie]
}
