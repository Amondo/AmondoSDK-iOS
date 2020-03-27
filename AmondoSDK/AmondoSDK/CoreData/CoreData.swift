//
//  CoreData.swift
//  Amondo
//
//  Created by Timothy Whiting on 17/01/2017.
//  Copyright © 2017 Arcopo. All rights reserved.
//

import UIKit
import CoreData

class SavedImprint: NSManagedObject {

    @NSManaged var title: String
    @NSManaged var location: String
    @NSManaged var date: Date
    @NSManaged var image: Data
    @NSManaged var id: String

    class func createInManagedObjectContext(_ moc: NSManagedObjectContext, title: String, location: String, date: Date, image: Data, id: String) -> SavedImprint {

        let newItem = NSEntityDescription.insertNewObject(forEntityName: "SavedImprint", into: moc) as! SavedImprint
        newItem.title = title
        newItem.location = location
        newItem.date = date
        newItem.image = image
        newItem.id = id
        return newItem

    }

    class func getAllEvents(_ moc: NSManagedObjectContext) -> [SavedImprint] {

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "SavedImprint")

        do {

            let results = try moc.fetch(fetchRequest) as! [SavedImprint]

            return results

        } catch {
            return []
        }

    }

}
