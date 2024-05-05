//
//  AsyncImageView.swift
//  BlockbusterVault
//
//  Created by Dev on 15/03/2024.
//

import SwiftUI
import CachedAsyncImage

struct AsyncImageView: View {
    @StateObject var viewModel: AsyncImageViewModel
    var body: some View {
        let displayTypeData = viewModel.getDisplayTypeURL()
        switch displayTypeData.type {
            case .image:
                return AnyView(
                    CachedAsyncImage(url: URL(string: displayTypeData.url), urlCache: .imageCache) { phase in
                        switch phase {
                            case .empty:
                                ProgressView()
                                    .frame(width: 50, height: 50)
                            case .success(let image):
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                            case .failure:
                                Image(systemName: "photo.artframe")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .tint(Color.black)
                                    .opacity(0.4)
                                    .frame(width: 50, height: 50)
                            @unknown default:
                                Text("Unknown state")
                        }
                    }
                )
            case .none:
                return AnyView(EmptyView())
        }
    }
}

struct AsyncImageView_Previews: PreviewProvider {
    static var previews: some View {
        AsyncImageView(viewModel: AsyncImageViewModel(urlPath: ""))
    }
}
