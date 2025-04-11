extension MainViewController: SortSegControlDelegate {
    func sortSegmentChanged(by sorting: SortingOption) {
        resetOptionSelection()

        mainViewModel.fetchMovies(by: sorting)

        let movieItems = mainViewModel.movieList.map { MovieItem.movieInfo($0) }

        updateSnapshot(with: movieItems)
    }
}
