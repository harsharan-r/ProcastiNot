//
//  HomeViewController.swift
//  ProcastiNot - Harsharan Rakhra App
//
//  Created by CoopStudent on 2022-07-24.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {


    @IBOutlet weak var greeting: UILabel!
    @IBOutlet weak var blueBackground: UIImageView!
    
 
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var task: UITextField!
    @IBOutlet weak var due: UITextField!
    
    
    struct Task{
        var task: String!
        var dueDate: String!
    }
    
    var tasks: [Task] = [Task(task: "Example Task", dueDate: "06/02")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        blueBackground.layer.cornerRadius = 49


        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        
        greeting.text = "Hi \(Auth.auth().currentUser?.displayName ?? "No Username")"
        greeting.sizeToFit()
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
    
    @IBAction func addTask(_ sender: Any) {
        validateFields()

    }
    
    func validateFields(){
        if(task.text?.isEmpty == true){
            print("No Task Text")
            return
        }
        
        if(due.text?.isEmpty == true){
            print("No Due Text")
            return
        }
        
        storeData()
    }
    
    func storeData(){
        tasks.append(Task(task: task.text, dueDate: due.text))
        if(tasks[0].task == "Example Task"){
            tasks.remove(at: 0)
        }
        NotificationCenter.default.post(name: Notification.Name("Tasks"), object: tasks)
        tableView.reloadData()
        task.text = ""
        due.text = ""
        print("data Added")
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return tasks.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "TaskTableCellID") as! TaskTableViewCell
        
        let task = tasks[indexPath.row]
        
        tableViewCell.task.text = task.task
        tableViewCell.date.text = task.dueDate
        
        return tableViewCell
        
                
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
