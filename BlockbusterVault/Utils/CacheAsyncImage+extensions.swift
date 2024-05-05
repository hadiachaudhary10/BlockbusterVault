//
//  CacheAsyncImage+extensions.swift
//  BlockbusterVault
//
//  Created by Dev on 15/03/2024.
//

import Foundation

extension URLCache {
    static let imageCache = URLCache(memoryCapacity: 512*1000*1000, diskCapacity: 1000*1000*1000)
}
