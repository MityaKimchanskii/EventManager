//
//  EventTableViewController.swift
//  EventManager
//
//  Created by Mitya Kim on 1/26/22.
//

import UIKit

class EventsListTableViewController: UITableViewController {
    
    // MARK: Properties
    var event: Event?
    var cell: EventTableViewCell?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        EventController.shared.fetchEvent()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EventController.shared.events.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as? EventTableViewCell else { return UITableViewCell() }
        let event = EventController.shared.events[indexPath.row]
        cell.event = event
        cell.delegate = self
        cell.updateView()
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let eventToDelete = EventController.shared.events[indexPath.row]
            EventController.shared.deleteEvent(event: eventToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if segue.identifier == "editEventSegue",
        let indexPath = tableView.indexPathForSelectedRow,
        let destinatioVC = segue.destination as? EventDetailViewController {
            let event = EventController.shared.events[indexPath.row]
            destinatioVC.event = event
        }
    }
}

extension EventsListTableViewController: isDoneDelegate {
    func eventButtonTapped(_ sender: EventTableViewCell) {
        guard let event = sender.event else { return }
        EventController.shared.toggleIsDone(event: event)
        sender.updateView()
    }
}
