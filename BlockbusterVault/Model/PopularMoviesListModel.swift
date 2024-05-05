//
//  MoviesListModel.swift
//  BlockbusterVault
//
//  Created by Dev on 14/03/2024.
//

import Foundation

struct PopularMoviesListModel: Codable {
    let results: [MovieItem]
}

struct MovieItem: Codable {
    let id: Int
    let title: String
    let poster_path: String
}
