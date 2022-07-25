//
//  LoginViewController.swift
//  ProcastiNot - Harsharan Rakhra App
//
//  Created by CoopStudent on 2022-07-23.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password:UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    // AUTO LOADS USER TO MAIN PAGE IS SOMEONE IS LOGGED IN
    override func viewDidAppear(_ animated: Bool) {
        checkUserInfo()
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        validateFields()
        
        
    }
    
    @IBAction func createAccountTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "signup")
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    
    func validateFields(){
        if(email.text?.isEmpty == true){
            print("No email text")
            return
        }
        
        if(password.text?.isEmpty == true){
            print("No password")
            return
        }
        
        login()
    }

    func login(){
        Auth.auth().signIn(withEmail: email.text!, password: password.text!) { [weak self] authResult, error in
            guard self != nil else {return}
            if let error = error{
                print(error.localizedDescription)
            }
            self?.checkUserInfo()
        }
    }
    
    func checkUserInfo(){
        if(Auth.auth().currentUser != nil){
            print(Auth.auth().currentUser!.uid)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "Home")
            vc.modalPresentationStyle = .overFullScreen
            present(vc, animated: true)
        }
    }
}
