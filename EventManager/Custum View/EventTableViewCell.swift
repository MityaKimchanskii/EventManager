//
//  EventTableViewCell.swift
//  EventManager
//
//  Created by Mitya Kim on 1/26/22.
//

import UIKit

protocol isDoneDelegate: AnyObject {
    func eventButtonTapped(_ sender: EventTableViewCell)
}

class EventTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var completionButton: UIButton!
    
    // MARK: - Properties
    var event: Event? {
        didSet {
            updateView()
        }
    }
    
    weak var delegate: isDoneDelegate?
    
    // MARK: - IBAction
    @IBAction func completionButtonTapped(_ sender: UIButton) {
        if let delegate = delegate {
            delegate.eventButtonTapped(self)
        }
    }
    
    // MARK: - Helper methods
    func updateView() {
        guard let event = event else { return }
        titleLabel.text = event.eventTitle
        if event.isDone {
            completionButton.setBackgroundImage(UIImage(systemName: "clock.fill"), for: .normal)
        } else {
            completionButton.setBackgroundImage(UIImage(systemName: "clock"), for: .normal)
        }
    }
}
