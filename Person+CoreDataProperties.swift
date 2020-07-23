//
//  Person+CoreDataProperties.swift
//  demo_relationship_coredata
//
//  Created by Mac172 on 23/01/20.
//  Copyright © 2020 Mac172. All rights reserved.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var name: String?
    @NSManaged public var age: String?
    @NSManaged public var emp_detail: Employee?

}
