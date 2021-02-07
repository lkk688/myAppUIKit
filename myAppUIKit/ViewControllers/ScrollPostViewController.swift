//
//  ScrollPostViewController.swift
//  myAppUIKit
//
//  Created by Kaikai Liu on 2/2/21.
//

import UIKit
import PhotosUI //for PHPicker
import os.log

class ScrollPostViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate, PHPickerViewControllerDelegate {
    
    var newsdata: NewsData?

    @IBOutlet weak var titleTxtfield: UITextField!
    @IBOutlet weak var nameTxtfield: UITextField!
    @IBOutlet weak var storyTextview: UITextView!
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var imgview: UIImageView!
    
    weak var activeField: UIView? //UITextField?
    
    // MARK: - Barbutton handling
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
    }
    
    
    
    //MARK: SelectImage in the form
    @IBAction func selectImage(_ sender: UITapGestureRecognizer) {
        print("selectImage")
        //Dismiss the keyboard
        storyTextview.resignFirstResponder()
        
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 1 //0 to mean unlimited
        configuration.filter = .images
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true)
        
    }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true)
        
        if let itemProvider = results.first?.itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) {
            //let previousImage = imgview.image
            itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                DispatchQueue.main.async {
                    guard let self = self, let image = image as? UIImage else {
                        print(error ?? "Cannot load image")
                        return
                    }
                    self.imgview.image = image
                }
                
            }
        }
    }
    
    //MARK: Add button in the form
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
        storyTextview.delegate = self
        
        scrollview.keyboardDismissMode = .onDrag //drag to dismiss the keyboard
        
        titleTxtfield.delegate = self
        titleTxtfield.tag = 0
        nameTxtfield.delegate = self
        nameTxtfield.tag = 1
        
        //storyTextview.placeholder = "Enter your story"
        storyTextview.addDoneButton(title: "Done", target: self, selector: #selector(tapDone(sender:)))
        storyTextview.backgroundColor = .secondarySystemBackground
        storyTextview.textColor = .secondaryLabel
        storyTextview.font = UIFont.preferredFont(forTextStyle: .body)
        storyTextview.layer.cornerRadius = 20
        //storyTextview.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
//        storyTextview.layer.shadowColor = UIColor.gray.cgColor;
//        storyTextview.layer.shadowOffset = CGSize(width: 0.75, height: 0.75)
//        storyTextview.layer.shadowOpacity = 0.4
//        storyTextview.layer.shadowRadius = 20
//        storyTextview.layer.masksToBounds = false
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardDidShow(notification:)),
                name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden(notification:)),
                name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    //MARK: keyboard handling
    @objc func keyboardDidShow(notification:NSNotification) {
        let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
        guard let activeField = activeField, let keyboardHeight = keyboardSize?.height else { return }

        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardHeight, right: 0.0)
        scrollview.contentInset = contentInsets
        scrollview.scrollIndicatorInsets = contentInsets
        var activeRect = activeField.convert(activeField.bounds,to: scrollview)
        if activeField is UITextView
        {
            activeRect.size.height = storyTextview.contentSize.height+20
        }
        scrollview.scrollRectToVisible(activeRect, animated: true)
    }
    
    @objc func keyboardWillBeHidden(notification:NSNotification) {
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func tapDone(sender: Any) {
            self.view.endEditing(true)
        }
    

    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        super.prepare(for: segue, sender: sender)
        
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        newsdata = NewsData.init(identifier: 1, title: titleTxtfield.text ?? "No title", name: nameTxtfield.text, story: storyTextview.text, photo: "Image1", rating: 0, weblink: nil, coordinate: nil)
    }
    
    
    // MARK: - TextField handling
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
        activeField = nil
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeField = textField
    }
    
    // MARK: - Textview handling
    //Tells the delegate when editing of the specified text view begins.
    func textViewDidBeginEditing(_ textView: UITextView) {
        activeField = textView
    }
    
    //Tells the delegate when editing of the specified text view ends.
    func textViewDidEndEditing(_ textView: UITextView) {
        print(textView.text ?? " ")
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if activeField != nil {
            if textView.contentSize.height >= 50 && textView.contentSize.height <= activeField!.bounds.height
            {
                var activeRect = activeField!.convert(activeField!.bounds,to: scrollview)
                activeRect.size.height = textView.contentSize.height
                scrollview.scrollRectToVisible(activeRect, animated: true)
            }
        }
    }
    

}
