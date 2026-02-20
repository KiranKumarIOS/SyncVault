//
//  PostEntity+CoreDataProperties.swift
//  SyncVault
//
//  Created by Vedas MacBook Air on 20/02/26.
//
//

import Foundation
import CoreData


extension PostEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PostEntity> {
        return NSFetchRequest<PostEntity>(entityName: "PostEntity")
    }

    @NSManaged public var id: Int64
    @NSManaged public var title: String?
    @NSManaged public var body: String?
    @NSManaged public var userID: Int64

}

extension PostEntity : Identifiable {

}
