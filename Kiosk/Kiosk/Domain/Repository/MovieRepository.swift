protocol MovieRepository {
    func fetchMovies(by sorting: SortingOption) -> [Movie]
}
