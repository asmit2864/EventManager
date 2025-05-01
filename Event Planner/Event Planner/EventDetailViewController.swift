//
//  EventDetailViewController.swift
//  Event Planner
//
//  Created by ARUN KUMAR YADAV on 28/04/25.
//

import UIKit

class EventDetailViewController: UIViewController {
    var event: Event?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Display event details if event is passed from HomeViewController
                if let event = event {
                    titleLabel.text = event.title
                    descriptionTextView.text = event.description
                    locationLabel.text = event.location
                    contactLabel.text = event.contact
                    budgetLabel.text = event.budget
                    maxParticipantsLabel.text = event.maxParticipants
                    dateLabel.text = formatDate(event.date)
                    categoryLabel.text = event.category
                }
        // Do any additional setup after loading the view.
    }
    
    func formatDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .none
        return dateFormatter.string(from: date)
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var categoryLabel: UILabel!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var maxParticipantsLabel: UILabel!
    @IBOutlet weak var budgetLabel: UILabel!
    @IBOutlet weak var contactLabel: UILabel!
    
    
    
    @IBAction func backbtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

}
