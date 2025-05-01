//
//  EventCreationViewController.swift
//  Event Planner
//
//  Created by ARUN KUMAR YADAV on 28/04/25.
//

import UIKit

struct Event {
    var title: String
    var date: Date
    var location: String
    var description: String
    var contact: String
    var category: String
    var maxParticipants: String
    var budget: String
}

class EventCreationViewController: UIViewController {
    
    // eventCreationHandler closure
    var eventCreationHandler: ((Event) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var maxParticipantsTextField: UITextField!
    @IBOutlet weak var categorySegmentedControl: UISegmentedControl!
    @IBOutlet weak var contactTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextField!
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        guard let title = titleTextField.text, !title.isEmpty,
              let location = locationTextField.text, !location.isEmpty,
              let description = descriptionTextView.text, !description.isEmpty,
              let contact = contactTextField.text, !contact.isEmpty,
              let maxParticipantsText = maxParticipantsTextField.text, let maxParticipants = Int(maxParticipantsText) else {
                
                let alert = UIAlertController(title: "Missing Fields", message: "Please fill all required fields.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                present(alert, animated: true)
                return
        }
        
        let category = categorySegmentedControl.titleForSegment(at: categorySegmentedControl.selectedSegmentIndex) ?? "Other"
        let date = datePicker.date
        let price = priceTextField.text ?? ""
        
        let newEvent = Event(
            title: title,
            date: date,
            location: location,
            description: description,
            contact: contact,
            category: category,
            maxParticipants: String(maxParticipants),
            budget: price
        )
        
        // Triggered the closure to pass data back
        eventCreationHandler?(newEvent)
        
        let alert = UIAlertController(title: "Success", message: "Event created successfully!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            self.dismiss(animated: true, completion: nil)
        }))
        present(alert, animated: true)
    }
    
    @IBAction func homebtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    
}
