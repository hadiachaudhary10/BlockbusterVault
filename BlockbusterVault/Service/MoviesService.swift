//
//  MoviesService.swift
//  BlockbusterVault
//
//  Created by Dev on 14/03/2024.
//

import Foundation

struct MoviesService {
    func getPopularMoviesList() async throws -> PopularMoviesListModel {
        let url = "https://api.themoviedb.org/3/movie/popular?language=en-US&page=1"
        do {
            return try await NetworkManager().fetchRequest(type: PopularMoviesListModel.self, url: url)
        } catch let error as NSError {
            throw error
        }
    }
    
    func getMovieDetails(id: String) async throws -> MovieDetailsModel {
        let url = "https://api.themoviedb.org/3/movie/\(id)?language=en-US"
        do {
            return try await NetworkManager().fetchRequest(type: MovieDetailsModel.self, url: url)
        } catch let error as NSError {
            throw error
        }
    }
}
