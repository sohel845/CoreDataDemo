//
//  Employee+CoreDataProperties.swift
//  demo_relationship_coredata
//
//  Created by Mac172 on 23/01/20.
//  Copyright © 2020 Mac172. All rights reserved.
//
//

import Foundation
import CoreData


extension Employee {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Employee> {
        return NSFetchRequest<Employee>(entityName: "Employee")
    }

    @NSManaged public var salary: String?
    @NSManaged public var designation: String?
    @NSManaged public var department: String?

}
