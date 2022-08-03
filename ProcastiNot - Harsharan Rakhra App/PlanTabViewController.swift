//
//  PlanTabViewController.swift
//  ProcastiNot - Harsharan Rakhra App
//
//  Created by CoopStudent on 2022-07-26.
//

import UIKit
import EventKit
import EventKitUI
import FirebaseAuth

class PlanTabViewController: UIViewController, EKEventEditViewDelegate, UITableViewDataSource, UITableViewDelegate{
 
    let eventStore = EKEventStore()
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var greeting: UILabel!
    @IBOutlet weak var blueBackground: UIImageView!
    
    var tasks: [HomeViewController.Task] = []
        
    override func viewDidLoad() {
        super.viewDidLoad()
        blueBackground.layer.cornerRadius = 49
        tableView.reloadData()
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "Home") as? HomeViewController
        tasks = vc!.tasks
        
        NotificationCenter.default.addObserver(self, selector: #selector(didGetNotification(_:)), name: Notification.Name("Tasks"), object: nil)
        

        // Do any additional setup after loading the view.
    }
    
    @objc func didGetNotification(_ notification: Notification){
        print("Notification Recieved")
        tasks = (notification.object as? [HomeViewController.Task])!
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        greeting.text = "Hi \(Auth.auth().currentUser?.displayName ?? "No Username")"
        greeting.sizeToFit()
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated:Bool){
        super.viewWillAppear(animated)
 
     }
    

    @IBAction func Logout(_ sender: Any) {
        do{
            
        try Auth.auth().signOut()
            
        }catch{
            print("Error")
        }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "login")
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
    }

    
    func eventEditViewController(_ controller: EKEventEditViewController, didCompleteWith action: EKEventEditViewAction ){
        controller.dismiss(animated: true)
    }
    
    func presentEventVc(_ title:String){
        
        let eventVC = EKEventEditViewController()
        
        eventVC.editViewDelegate = self
        eventVC.eventStore = EKEventStore()
        
        let event = EKEvent(eventStore: eventVC.eventStore)
        event.title = title
        event.startDate = Date()
        eventVC.event = event
        
        self.present(eventVC, animated: true, completion: nil)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "planTableViewCell") as! PlanTableViewCell
        tableViewCell.TaskLabel.text = tasks[indexPath.row].task
        tableViewCell.PlanLabel.layer.masksToBounds = true
        tableViewCell.PlanLabel.layer.cornerRadius = 25

        
        return tableViewCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let title = tasks[indexPath.row].task

        switch EKEventStore.authorizationStatus(for: .event)
        {
        case .notDetermined:
            eventStore.requestAccess(to: .event){granted, error in
                if granted{
                    print("Authorised")
                    self.presentEventVc(title!)
                }
            }
        case .authorized:
            print("Authorised")
            self.presentEventVc(title!)
        default:
            break
        }
    }
    
    @IBAction func calenderTapped(_ sender: Any) {
        if let url = URL(string: "calshow://") {
          UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
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
