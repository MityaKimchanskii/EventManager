//
//  EventController.swift
//  EventManager
//
//  Created by Mitya Kim on 1/26/22.
//
import CoreData

class EventController {
    
    static let shared = EventController()
    
    private init() {}
    
    private lazy var fetchRequest: NSFetchRequest<Event> = {
        let request = NSFetchRequest<Event>(entityName: "Event")
        request.predicate = NSPredicate(value: true)
        return request
    }()
    
    var events: [Event] = []
    
    // MARK: - CRUD
    func createEvent(eventTitle: String, eventDate: Date) {
        let event = Event(eventTitle: eventTitle, eventDate: eventDate)
        events.append(event)
        CoreDataStack.saveContext()
    }
    
    func fetchEvent() {
        let events = (try? CoreDataStack.context.fetch(self.fetchRequest)) ?? []
        self.events = events
    }
    
    func updateEvent(event: Event, title: String, date: Date) {
        event.eventTitle = title
        event.eventDate = date
        CoreDataStack.saveContext()
    }
    
    func deleteEvent(event: Event) {
        guard let index = events.firstIndex(of: event) else { return }
        events.remove(at: index)
        CoreDataStack.context.delete(event)
        CoreDataStack.saveContext()
    }
    
    func toggleIsDone(event: Event) {
        event.isDone.toggle()
        CoreDataStack.saveContext()
    }
}


