protocol MovieDataSource {
    func fetchMovies(by sorting: SortingOption) -> [Movie]
}
