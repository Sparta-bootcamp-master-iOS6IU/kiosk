protocol MovieDataSource {
    func fetchMovies(by sortedBy: String) -> [Movie]
}
