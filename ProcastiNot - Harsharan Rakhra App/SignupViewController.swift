//
//  SignupViewController.swift
//  ProcastiNot - Harsharan Rakhra App
//
//  Created by CoopStudent on 2022-07-23.
//

import UIKit
import FirebaseAuth
import Firebase


class SignupViewController: UIViewController {


    
    
    
    @IBOutlet weak var textfield: UITextField!
    @IBOutlet weak var haveAnAccount: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
   
    @IBAction func signupTapped(_ sender: Any) {
        validateFields()
    }

    
    
    @IBAction func alreadyHaveAnAccountTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "login")
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
        signup()
        
    }
    
    func signup(){
        
        print("signup")
        Auth.auth().createUser(withEmail: email.text!, password: password.text!){ (user, error) in
            if(error == nil && user != nil){
                
                /*auto signing in after user creation
                 Auth.auth().signIn(withEmail: self.email.text!, password: self.password.text!) { [weak self] authResult, error in
                    guard self != nil else {return}
                    if let error = error{
                        print(error.localizedDescription)
                    }else {
                    }
                }*/
                
                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                changeRequest?.displayName = self.username.text!
                changeRequest?.commitChanges { error in
                    if(error == nil){
                        print("User display name changed")
                    }
                    
                    print(self.username.text!)
                }
                
            }else{
                print("Error creating user: \(error!.localizedDescription)")
            }
        }
        
                
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "login")
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
            
        }
    }


