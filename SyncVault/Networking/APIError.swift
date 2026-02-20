//
//  APIError.swift
//  SyncVault
//
//  Created by Vedas MacBook Air on 20/02/26.
//

import Foundation

enum APIError: Error {
    
    case invalidURL
    case invalidResponse
    case invalidStatusCode(Int)
    case decodingError
    case noData
    case unknown(Error)
    
    var message: String {
        switch self {
        case .invalidURL:
            return "Invalid URL."
        case .invalidResponse:
            return "Invalid server response."
        case .invalidStatusCode(let code):
            return "Server returned status code \(code)."
        case .decodingError:
            return "Failed to decode data."
        case .noData:
            return "No data received from server."
        case .unknown(let error):
            return error.localizedDescription
        }
    }
}
