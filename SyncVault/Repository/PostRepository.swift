//
//  Repository.swift
//  SyncVault
//
//  Created by Vedas MacBook Air on 20/02/26.
//

import Foundation
import CoreData


final class PostRepository{
    private let apiManager = APIManager.shared
    private let context = CoreDataManager.shared.context
    
    func fetchPosts() async throws -> [PostEntity] {
        do {
            print("🌐 Trying to fetch from API...")
            let postDTOs = try await APIManager.shared.fetchPosts()
            try saveToCoreData(postDTOs)
            print("📦 Returning fresh data from Core Data")
            return try fetchFromCoreData()
        } catch {
            print("⚠️ API Failed. Loading from Core Data (Offline Mode)")
            return try fetchFromCoreData()
        }
    }
    private func saveToCoreData(_ posts: [PostDTO]) throws {
        
        // 1️⃣ Delete old posts to avoid duplicates
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = PostEntity.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        try context.execute(deleteRequest)
        
        // 2️⃣ Insert new posts
        for post in posts {
            let entity = PostEntity(context: context)
            entity.id = Int64(post.id)
            entity.userID = Int64(post.userId)
            entity.title = post.title
            entity.body = post.body
        }
        
        // 3️⃣ Save changes
        try context.save()
    }
    private func fetchFromCoreData() throws -> [PostEntity] {
        
        let request: NSFetchRequest<PostEntity> = PostEntity.fetchRequest()
        
        // Optional: sort by id
        request.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        
        let results = try context.fetch(request)
        
        return results
    }
}
