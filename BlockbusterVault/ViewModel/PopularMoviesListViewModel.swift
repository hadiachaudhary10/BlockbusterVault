//
//  PopularMoviesListViewModel.swift
//  BlockbusterVault
//
//  Created by Dev on 15/03/2024.
//

import Foundation

@MainActor
class PopularMoviesListViewModel: ObservableObject {
    @Published var list: [MovieItem] = []
    @Published var result: ResultType = .Fetching
    
    enum displayType {
        case image
        case none
    }
    
    init() {
        fetchPopularMoviesList()
    }
    
    private func fetchPopularMoviesList() {
        Task {
            do {
                let moviesList = try await MoviesService().getPopularMoviesList()
                list = moviesList.results
                result = .Success
            } catch {
                result = .NoData
            }
        }
    }
}
