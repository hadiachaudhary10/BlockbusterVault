//
//  MovieDetailsView.swift
//  BlockbusterVault
//
//  Created by Dev on 15/03/2024.
//

import SwiftUI
import StarRatingViewSwiftUI

struct MovieDetailsView: View {
    @StateObject var viewModel: MoviesDetailsViewModel
    
    var body: some View {
        Group {
            switch viewModel.result {
                case .Success:
                    if let details = viewModel.details {
                        GeometryReader { geo in
                            ScrollView {
                                AsyncImageView(viewModel: AsyncImageViewModel(urlPath: details.backdrop_path))
                                    .frame(width: geo.size.width, height: geo.size.height * 0.4)
                                    .background(Color.backgroundColor)
                                HStack {
                                    VStack(alignment: .leading) {
                                        headerView(title: details.title, releaseDate: details.release_date, adultMovie: details.adult)
                                        movieReview(size: geo.size, count: String(details.vote_count))
                                        genreReview(genres: details.genres)
                                        movieOverview(overview: details.overview)
                                        if details.production_companies.count > 0 {
                                            productionCompany(size: geo.size, companies: details.production_companies)
                                        }
                                    }
                                    Spacer()
                                }
                                .padding(.all)
                            }
                        }
                    } else {
                        errorView
                    }
                case .NoData:
                    errorView
                case .Fetching:
                    ProgressView()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(
            Color.clear,
            for: .navigationBar
        )
        .toolbarBackground(.visible, for: .navigationBar)
    }
    
    func genreReview(genres: [GenreDetails]) -> some View {
        return HStack {
            ForEach(genres, id: \.name) { genre in
                LabelView(
                    text: genre.name,
                    font: .caption,
                    isBold: true,
                    foregroundColor: Color.lotusColor
                )
                .padding(.all, 5)
                .background(
                    Capsule().stroke(Color.lotusColor, lineWidth: 1)
                )
            }
        }
        .padding(.vertical)
    }
    
    var errorView: some View {
        Group {
            Image(systemName: "exclamationmark.triangle")
                .imageScale(.large)
                .foregroundColor(.black)
                .padding(.bottom)
            LabelView(
                text: "Unable to fetch movie details!",
                font: .title3)
        }
    }
    
    func headerView(title: String, releaseDate: String, adultMovie: Bool) -> some View {
        return Group {
            LabelView(
                text: title,
                font: .title,
                isBold: true
            )
            HStack {
                LabelView(
                    text: releaseDate,
                    font: .subheadline
                )
                if adultMovie {
                    LabelView(
                        text: "18+",
                        font: .subheadline
                    )
                    .padding(.all, 1.5)
                    .background(
                       Rectangle()
                        .stroke(.black, lineWidth: 1)
                    )
                }
                Spacer()
            }
            
        }
    }
    
    func movieOverview(overview: String) -> some View {
        return Group {
            LabelView(
                text: "Overview:",
                font: .body,
                isBold: true
            )
            .padding(.bottom, 5)
            LabelView(
                text: overview,
                font: .body
            )
            .padding(.bottom)
        }
    }
    
    func movieReview(size: CGSize, count: String) -> some View {
        return HStack {
            StarRatingView(rating: viewModel.getStarRating())
                .frame(width: size.width * 0.3, height: size.height * 0.03)
                .padding(.trailing, size.width * 0.03)
            LabelView(
                text: count,
                font: .body,
                isBold: true
            )
            LabelView(
                text: "Votes",
                font: .body,
                isBold: true
            )
            Spacer()
        }
    }
    
    func productionCompany(size: CGSize, companies: [Production_Companies]) -> some View {
        return Group {
            LabelView(
                text: "Production Companies:",
                font: .body,
                isBold: true
            )
            ScrollView(.horizontal) {
                LazyHGrid(rows: [GridItem(.fixed(size.width * 0.05))], spacing: size.width * 0.05) {
                    ForEach(companies, id: \.name) { company in
                        AsyncImageView(viewModel: AsyncImageViewModel(urlPath: company.logo_path ?? ""))
                            .frame(width: size.width * 0.2)
                            .padding(.horizontal, size.width * 0.05)
                    }
                }
                .padding()
            }
        }
    }
}

struct MovieDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailsView(viewModel: MoviesDetailsViewModel(selectedID: ""))
    }
}
