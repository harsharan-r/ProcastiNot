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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        blueBackground.layer.cornerRadius = 49
        tableView.reloadData()

        // Do any additional setup after loading the view.
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
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Home") as? HomeViewController{
            return vc.tasks.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "planTableViewCell") as! PlanTableViewCell
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Home") as? HomeViewController{
            tableViewCell.TaskLabel.text = vc.tasks[indexPath.row].task
        }
        
        
        return tableViewCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var title = ""
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Home") as? HomeViewController{
            title = vc.tasks[indexPath.row].task
            print(title)
        }
        
        print("test")
        
        switch EKEventStore.authorizationStatus(for: .event)
        {
        case .notDetermined:
            eventStore.requestAccess(to: .event){granted, error in
                if granted{
                    print("Authorised")
                    self.presentEventVc(title)
                }
            }
        case .authorized:
            print("Authorised")
            self.presentEventVc(title)
        default:
            break
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
