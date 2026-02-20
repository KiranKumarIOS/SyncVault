//
//  PostDTO.swift
//  SyncVault
//
//  Created by Vedas MacBook Air on 20/02/26.
//

import Foundation

struct PostDTO: Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
