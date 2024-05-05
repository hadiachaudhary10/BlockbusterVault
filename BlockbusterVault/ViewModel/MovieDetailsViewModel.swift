//
//  MovieDetailsViewModel.swift
//  BlockbusterVault
//
//  Created by Dev on 15/03/2024.
//

import Foundation

@MainActor
class MoviesDetailsViewModel: ObservableObject {
    @Published var details: MovieDetailsModel?
    @Published var result: ResultType = .Fetching
    private var selectedItemID: String
    
    enum displayType {
        case image
        case none
    }
    
    init(selectedID: String) {
        selectedItemID = selectedID
        fetchMovieDetails()
    }

    private func fetchMovieDetails() {
        Task {
            do {
                var movieDetails = try await MoviesService().getMovieDetails(id: selectedItemID)
                movieDetails.production_companies = movieDetails.production_companies.filter { company in
                    return company.logo_path != nil
                }
                details = movieDetails
                result = .Success
            } catch {
                result = .NoData
            }
        }
    }
    
    func getStarRating() -> Float {
        if let details {
            return (details.vote_average / 10.0) * 5.0
        }
        return 0.0
    }
}
