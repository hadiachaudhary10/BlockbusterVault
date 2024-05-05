//
//  BlockbusterVaultApp.swift
//  BlockbusterVault
//
//  Created by Dev on 13/03/2024.
//

import SwiftUI

@main
struct BlockbusterVaultApp: App {
    var body: some Scene {
        WindowGroup {
            PopularMoviesListView(viewModel: PopularMoviesListViewModel())
        }
    }
}
