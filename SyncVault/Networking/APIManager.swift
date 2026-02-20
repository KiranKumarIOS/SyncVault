//
//  APIManager.swift
//  SyncVault
//
//  Created by Vedas MacBook Air on 20/02/26.
//

import Foundation

final class APIManager {
    
    static let shared = APIManager()
    private init() {}
    
    func fetchPosts() async throws -> [PostDTO] {
        
        guard let url = URL(string: baseURL + endpoint) else {
            throw APIError.invalidURL
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw APIError.invalidResponse
            }
            guard 200...299 ~= httpResponse.statusCode  else {
                throw APIError.invalidStatusCode(httpResponse.statusCode)
            }
            guard !data.isEmpty else {
                throw APIError.noData
            }
            do {
                let decodedData = try JSONDecoder().decode([PostDTO].self, from: data)
                if decodedData.isEmpty  {
                    throw APIError.noData
                }
                return decodedData
            }catch {
                throw APIError.decodingError
            }
        } catch {
            throw APIError.unknown(error)
        }
        
    }
}
