//
//  MovieDetailsModel.swift
//  BlockbusterVault
//
//  Created by Dev on 15/03/2024.
//

import Foundation

struct MovieDetailsModel: Codable {
    let title: String
    let adult: Bool
    let backdrop_path: String
    let release_date: String
    let overview: String
    let vote_count: Int
    let vote_average: Float
    let genres: [GenreDetails]
    var production_companies: [Production_Companies]
}

struct Production_Companies: Codable {
    let name: String
    let logo_path: String?
}

struct GenreDetails: Codable {
    let name: String
}
