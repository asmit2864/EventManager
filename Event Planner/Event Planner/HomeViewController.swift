//
//  HomeViewController.swift
//  Event Planner
//
//  Created by ARUN KUMAR YADAV on 28/04/25.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDataSource , UITableViewDelegate{
    
    var events: [Event] = []
    var filteredEvents: [Event] = []
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowEventDetail",
                   let destinationVC = segue.destination as? EventDetailViewController,
                   let selectedIndexPath = eventTableView.indexPathForSelectedRow {
                    let selectedEvent = events[selectedIndexPath.row]
                    
                    destinationVC.event = selectedEvent
            
                    destinationVC.modalPresentationStyle = .fullScreen
                }
    }
    
    func updateBackgroundView() {
        if events.isEmpty {
            let messageLabel = UILabel()
            messageLabel.text = "No Events"
            messageLabel.textAlignment = .center
            messageLabel.textColor = .gray
            messageLabel.font = UIFont.systemFont(ofSize: 20)
            messageLabel.sizeToFit()

            eventTableView.backgroundView = messageLabel
            eventTableView.separatorStyle = .none
        } else {
            eventTableView.backgroundView = nil
            eventTableView.separatorStyle = .singleLine
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
            eventTableView.dataSource = self
            eventTableView.delegate = self
            updateBackgroundView()
            
    }
    
    @IBAction func addBtnTapped(_ sender: Any) {
        guard let eventCreationVC = storyboard?.instantiateViewController(withIdentifier: "EventCreationViewController") as? EventCreationViewController else {
                return
            }
        
        // Set the eventCreationHandler closure
        eventCreationVC.eventCreationHandler = { [weak self] newEvent in
            // Add the new event to the events array
            self?.events.append(newEvent)
            self?.eventTableView.reloadData()
            self?.filterEvents()
        }
        eventCreationVC.modalPresentationStyle = .fullScreen
        present(eventCreationVC, animated: true, completion: nil)
    }


    @IBOutlet weak var eventTableView: UITableView!
    
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredEvents.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath)
        
        let event = filteredEvents[indexPath.row]
        
        cell.textLabel?.text = event.title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            performSegue(withIdentifier: "ShowEventDetail", sender: indexPath)
    }
    
    func filterEvents() {
        let selectedIndex = categorySegmentedControl.selectedSegmentIndex
        let selectedCategory = categorySegmentedControl.titleForSegment(at: selectedIndex)

        if selectedCategory == "All" {
            filteredEvents = events
        } else {
            filteredEvents = events.filter { $0.category == selectedCategory }
        }

        eventTableView.reloadData()
        updateBackgroundView()
    }


    @IBAction func homebtn(_ sender: Any) {
        if let loginSignupVC = storyboard?.instantiateViewController(withIdentifier: "HomePageViewController") {
                print("✅ LoginSignupController found!")
                loginSignupVC.modalPresentationStyle = .fullScreen
                present(loginSignupVC, animated: true, completion: nil)
            } else {
                print("❌ Could not find LoginSignupController")
            }
    }
    
    @IBOutlet weak var categorySegmentedControl: UISegmentedControl!
    @IBAction func categoryChanged(_ sender: Any) {
        filterEvents()
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
