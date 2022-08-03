//
//  PlanTabViewController.swift
//  ProcastiNot - Harsharan Rakhra App
//
//  Created by CoopStudent on 2022-07-26.
//

import UIKit
import FirebaseAuth

class CellClass: UITableViewCell{
    
}

class ControlTabViewController: UIViewController{

    @IBOutlet weak var greeting: UILabel!
    @IBOutlet weak var blueBackground: UIImageView!
    @IBOutlet weak var selectAppButton: UIButton!
    @IBOutlet weak var notificationSwitch: UISwitch!
    @IBOutlet weak var appBlockSwitch: UISwitch!
    @IBOutlet weak var automaticSwitch: UISwitch!
    
    let transparentView = UIView()
    let tableView = UITableView()
    
    var selectedButton = UIButton()
    var dataSource = [String()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        blueBackground.layer.cornerRadius = 49
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CellClass.self, forCellReuseIdentifier: "Cell")
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
    
    @IBAction func notificationSwitchTapped(_ sender: Any) {
    }
    @IBAction func automaticSwtichTapped(_ sender: Any) {
    }
    @IBAction func automaticSwitchTapped(_ sender: Any) {
        if(automaticSwitch.isOn){
            notificationSwitch.setOn(true, animated: true)
            appBlockSwitch.setOn(true, animated: true)
        }
    }
    
    
    
    func addTransparentView(frames: CGRect){
        let window = UIApplication.shared.keyWindow
        transparentView.frame = window?.frame ?? self.view.frame
        self.view.addSubview(transparentView)
        
        tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
        self.view.addSubview(tableView)
        tableView.layer.cornerRadius = 5
        
        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        tableView.reloadData()
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(removeTransparentView))
        transparentView.addGestureRecognizer(tapgesture)
        transparentView.alpha = 0
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0.5
            self.tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height + 5, width: frames.width, height: 200)
        }, completion: nil)
    }
    
    @objc func removeTransparentView(){
        let frames = selectedButton.frame
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0
            self.tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
        }, completion: nil)
    }
    
    @IBAction func onSelectAppTapped(_ sender: Any) {
        dataSource = ["Instagram","Tiktok","Twitter","Youtube","Snapchat","Reddit"]
        selectedButton = selectAppButton
        addTransparentView(frames: selectAppButton.frame)
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

extension ControlTabViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = dataSource[indexPath.row]
        cell.textLabel?.font = UIFont(name: "Typo Round Regular Demo", size: 20)
        cell.imageView?.image = UIImage(named: "controlicon")
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectAppButton.setTitle(dataSource[indexPath.row], for: .normal)
        selectAppButton.titleLabel?.font = UIFont(name: "AOKI", size: 20)
        removeTransparentView()
    }
}
