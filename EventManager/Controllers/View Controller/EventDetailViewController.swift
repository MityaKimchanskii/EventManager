//
//  EventViewController.swift
//  EventManager
//
//  Created by Mitya Kim on 1/26/22.
//

import UIKit

class EventDetailViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var eventLabel: UILabel!
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var event: Event?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let event = event {
            eventLabel.text = "Edit Event"
            titleTF.text = event.eventTitle
            datePicker.date = event.eventDate ?? Date()
        } else {
            eventLabel.text = "Add New Event"
        }
    }
    
    // MARK: - IBAction
    @IBAction func saveButton(_ sender: UIButton) {
        guard let eventTitle = titleTF.text, !eventTitle.isEmpty else { return }
        
        let eventDate = datePicker.date
        if let event = event {
            EventController.shared.updateEvent(event: event, title: eventTitle, date: eventDate)
        } else {
            EventController.shared.createEvent(eventTitle: eventTitle, eventDate: eventDate)
        }
        navigationController?.popViewController(animated: true)
    }
}
