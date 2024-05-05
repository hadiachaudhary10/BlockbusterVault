//
//  AsyncImageViewModel.swift
//  BlockbusterVault
//
//  Created by Dev on 15/03/2024.
//

import Foundation

class AsyncImageViewModel: ObservableObject {
    var url: String
    
    enum displayType {
        case image
        case none
    }
    
    init(urlPath: String) {
        url = urlPath
    }
    
    func getDisplayTypeURL() -> (url: String, type: displayType) {
        if url != "" {
            return ("https://image.tmdb.org/t/p/w500" + url, .image)
        }
        return ("", .none)
    }
}
