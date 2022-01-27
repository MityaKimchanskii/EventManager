//
//  Event+Convenience.swift
//  EventManager
//
//  Created by Mitya Kim on 1/26/22.
//

import CoreData

extension Event {
    @discardableResult convenience init(eventTitle: String, eventDate: Date, isDone: Bool = false, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.eventTitle = eventTitle
        self.eventDate = eventDate
        self.isDone = isDone
    }
}
