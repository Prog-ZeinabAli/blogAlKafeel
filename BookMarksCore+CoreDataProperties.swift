//
//  BookMarksCore+CoreDataProperties.swift
//  
//
//  Created by turath alanbiaa on 5/20/20.
//
//

import Foundation
import CoreData


extension BookMarksCore {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BookMarksCore> {
        return NSFetchRequest<BookMarksCore>(entityName: "BookMarksCore")
    }

    @NSManaged public var contentBM: String?
    @NSManaged public var nameBM: String?
    @NSManaged public var postIdBM: String?
    @NSManaged public var titleBM: String?

}
