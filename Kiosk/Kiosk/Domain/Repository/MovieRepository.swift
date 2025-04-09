protocol MovieRepository {
    func fetchMovies(by sorting: String) -> [Movie]
}
