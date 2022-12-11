import Foundation

protocol MoviesLoading {
    func loadMovies(handler: @escaping (Result<MostPopularMovies, Error>) -> Void)
}

struct MoviesLoader: MoviesLoading {
    
    private enum LoadingError: Error {
        case parseError
        case noDataError
    }
    
    // MARK: - NetworkClient
    private let netWorkClient: NetworkRouting
    
    init(netWorkClient: NetworkRouting = NetworkClient()) {
        self.netWorkClient = netWorkClient
    }
    
    // MARK: - URL
    private var mostPopularMoviesUrl: URL {
        guard let url = URL(string: "https://imdb-api.com/en/API/Top250Movies/k_s2sh983j") else {
            preconditionFailure("Unable to construct mostPopularMoviesUrl")
        }
        return url
    }
    
    func loadMovies(handler: @escaping (Result<MostPopularMovies, Error>) -> Void) {
        netWorkClient.fetch(url: mostPopularMoviesUrl) { result in
            switch result {
            case .success(let data):
                do {
                    let movies = try JSONDecoder().decode(MostPopularMovies.self, from: data)
                    handler(.success(movies))
                } catch {
                    handler(.failure(LoadingError.parseError))
                }
                
            case .failure(_):
                handler(.failure(LoadingError.noDataError))
            }
        }
    }
}
