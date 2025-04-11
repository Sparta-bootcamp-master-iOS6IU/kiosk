import Foundation

struct DefaultMovieDataSource: MovieDataSource {
    private typealias File = DataConstant.File

    func fetchMovies(by sorting: SortingOption) -> [Movie] {
        switch sorting {
        case .popularity:
            return fetch(from: File.byPopularity)
        case .releaseDate:
            return fetch(from: File.byReleaseDate)
        case .title:
            return fetch(from: File.byTitle)
        }
    }

    private func fetch(from fileName: String) -> [Movie] {
        Bundle.main.path(forResource: fileName, ofType: DataConstant.File.type)
            .flatMap { try? Data(contentsOf: URL(fileURLWithPath: $0)) }
            .flatMap { try? JSONDecoder().decode([Movie].self, from: $0) } ?? []
    }
}
