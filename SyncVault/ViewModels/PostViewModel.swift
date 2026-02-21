//
//  PostViewModel.swift
//  SyncVault
//
//  Created by Vedas MacBook Air on 20/02/26.
//

import Foundation

@MainActor
final class PostViewModel {
    
    private let repository = PostRepository()
    
    private(set) var posts: [PostEntity] = []
    
    var onDataUpdated: (() -> Void)?
    var onError: ((String) -> Void)?
    var onLoading: ((Bool) -> Void)?
    
    func fetchPosts() {
        onLoading?(true)
        defer { onLoading?(false) }

        Task {
            do {
                let data = try await repository.fetchPosts()
                
                if data.isEmpty {
                    onError?("You're offline and no cached data is available.")
                } else {
                    posts = data
                    onDataUpdated?()
                }
                
            } catch {
                onError?("Something went wrong.")
            }
        }
    }
    
}
