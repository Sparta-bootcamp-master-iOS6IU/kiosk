import Foundation

struct DefaultMovieDataSource: MovieDataSource {
    private typealias File = DataConstant.File

    func fetchMovies(by sortedBy: String) -> [Movie] {
        switch sortedBy {
        case File.byPopularity:
            return fetch(from: File.byPopularity)
        case File.byReleaseDate:
            return fetch(from: File.byReleaseDate)
        case File.byTitle:
            return fetch(from: File.byTitle)
        default:
            return []
        }
    }

    private func fetch(from fileName: String) -> [Movie] {
        Bundle.main.path(forResource: fileName, ofType: DataConstant.File.type)
            .flatMap { try? Data(contentsOf: URL(fileURLWithPath: $0)) }
            .flatMap { try? JSONDecoder().decode([Movie].self, from: $0) } ?? []
    }
}
