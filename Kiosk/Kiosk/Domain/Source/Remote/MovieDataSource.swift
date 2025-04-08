protocol MovieDataSource {
    func fetchMovies(by sorting: String) -> [Movie]
}
