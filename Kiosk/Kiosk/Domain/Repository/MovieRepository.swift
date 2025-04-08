protocol MovieRepository {
    func fetchMovies(by sortedBy: String) -> [Movie]
}
