protocol MovieUseCase {
    func fetchMovies(by sorting: SortingOption) -> [Movie]
}
