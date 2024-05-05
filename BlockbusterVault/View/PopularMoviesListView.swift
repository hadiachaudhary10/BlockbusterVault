//
//  PopularMoviesList.swift
//  BlockbusterVault
//
//  Created by Dev on 15/03/2024.
//

import SwiftUI

struct PopularMoviesListView: View {
    @StateObject var viewModel: PopularMoviesListViewModel
    var body: some View {
        NavigationStack {
            Group {
                switch viewModel.result {
                    case .Success:                        
                        GeometryReader { geo in
                            ScrollView {
                                LazyVGrid(columns: [GridItem(.flexible(), spacing: geo.size.width * 0.1), GridItem(.flexible(), spacing: 10)], spacing: 10) {
                                    ForEach(viewModel.list, id: \.id) { movie in
                                        NavigationLink(destination: MovieDetailsView(viewModel: MoviesDetailsViewModel(selectedID: String(movie.id)))) {
                                            VStack {
                                                imageView(size: geo.size, path: movie.poster_path)
                                                AnimatedTextView(text: movie.title)
                                                    .frame(width: geo.size.width * 0.35)
                                            }
                                            .frame(width: geo.size.width * 0.4, height: geo.size.height * 0.3)
                                            .padding(.all)
                                        }
                                    }
                                }
                                .padding()
                            }
                        }
                        
                        
                    case .NoData:
                        Image(systemName: "exclamationmark.triangle")
                            .imageScale(.large)
                            .foregroundColor(.black)
                            .padding(.bottom)
                        LabelView(
                            text: "Unable to fetch movies list!",
                            font: .title3)
                    case .Fetching:
                        ProgressView()
                }
            }
            .navigationTitle("Popular Movies")
            .toolbarBackground(
                Color.themeColor,
                for: .navigationBar
            )
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }
    
    func imageView(size: CGSize, path: String) -> some View {
        return AsyncImageView(viewModel: AsyncImageViewModel(urlPath: path))
            .frame(width: size.width * 0.35, height: size.height * 0.27)
            .background(Color.backgroundColor)
            .cornerRadius(10)
    }
}

struct PopularMoviesListView_Previews: PreviewProvider {
    static var previews: some View {
        PopularMoviesListView(viewModel: PopularMoviesListViewModel())
    }
}
