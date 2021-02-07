//
//  ViewController.swift
//  myAppUIKit
//
//  Created by Kaikai Liu on 1/31/21.
//

import UIKit

class PostViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var titleTxtfield: UITextField!
    @IBOutlet weak var nameTxtfield: UITextField!
    @IBOutlet weak var storyTextview: UITextView!
    
    @IBAction func addBtn(_ sender: UIButton) {
        // Create the action buttons for the alert.
        let defaultAction = UIAlertAction(title: "OK",
                            style: .default) { (action) in
            // Respond to user selection of the action.
            print("User pressed OK")
        }
        // Create and configure the alert controller.
        let alert = UIAlertController(title: "Tile is empty",
             message: "You need to add title.",
             preferredStyle: .alert)
        alert.addAction(defaultAction)
        
        if titleTxtfield.text?.isEmpty == true {
            self.present(alert, animated: true) {
                  // The alert was presented
                print("alert was presented")
            }
        }else{
            print("save data")
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        titleTxtfield.delegate = self
        titleTxtfield.tag = 0
        nameTxtfield.delegate = self
        nameTxtfield.tag = 1
        
        storyTextview.placeholder = "Enter your story"
        storyTextview.addDoneButton(title: "Done", target: self, selector: #selector(tapDone(sender:)))
        storyTextview.backgroundColor = .secondarySystemBackground
        storyTextview.textColor = .secondaryLabel
        storyTextview.font = UIFont.preferredFont(forTextStyle: .body)
        storyTextview.layer.cornerRadius = 20
        storyTextview.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        storyTextview.layer.shadowColor = UIColor.gray.cgColor;
        storyTextview.layer.shadowOffset = CGSize(width: 0.75, height: 0.75)
        storyTextview.layer.shadowOpacity = 0.4
        storyTextview.layer.shadowRadius = 20
        storyTextview.layer.masksToBounds = false

    }
    
    @objc func tapDone(sender: Any) {
            self.view.endEditing(true)
        }
    
    //You need to specify that the text field should resign its first-responder status when the user taps a button to end editing in the text field. You do this in the textFieldShouldReturn(_:) method, (called when the user taps Return on the keyboard)
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //textField.resignFirstResponder()
        
        //Option2
//        if (textField.tag == 0) {
//            titleTxtfield.resignFirstResponder()
//        }
//        if (textField.tag == 1) {
//            nameTxtfield.resignFirstResponder()
//        }

        //Option3
        switch textField {
            case titleTxtfield:
                nameTxtfield.becomeFirstResponder()
            case nameTxtfield:
                nameTxtfield.resignFirstResponder()
            default:
                textField.resignFirstResponder()
            }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print(textField.text ?? "  ")
    }


}

