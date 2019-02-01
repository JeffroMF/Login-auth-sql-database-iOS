//
//  RegisterVC.swift
//  Trybes v2
//
//  Created by Bruno Campos on 1/4/19.
//  Copyright © 2019 Bruno Campos. All rights reserved.
//

import UIKit

class RegisterVC: UIViewController {

    // cons obj
    @IBOutlet weak var emailView_width: NSLayoutConstraint!
    @IBOutlet weak var nameView_width: NSLayoutConstraint!
    @IBOutlet weak var passwordView_width: NSLayoutConstraint!
    @IBOutlet weak var birthdayView_width: NSLayoutConstraint!
    @IBOutlet weak var genderView_width: NSLayoutConstraint!
    @IBOutlet weak var contentView_width: NSLayoutConstraint!
    
    //ui obj
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var birthdayTextField: UITextField!
    
    @IBOutlet weak var emailContinueButton: UIButton!
    @IBOutlet weak var fullNameContinueButton: UIButton!
    @IBOutlet weak var passwordContinueButton: UIButton!
    @IBOutlet weak var birthdayContinueButton: UIButton!
    @IBOutlet weak var femaleGenderButton: UIButton!
    @IBOutlet weak var maleGenderButton: UIButton!
    
    @IBOutlet weak var footerView: UIView!
    //code obj
    var datePicker = UIDatePicker()
    
    
    
    //first loading function when the page is loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //adjust width of the views with the screen of the device
        contentView_width.constant = self.view.frame.width * 5
        
        emailView_width.constant = self.view.frame.width
        nameView_width.constant = self.view.frame.width
        passwordView_width.constant = self.view.frame.width
        birthdayView_width.constant = self.view.frame.width
        genderView_width.constant = self.view.frame.width
        
        //make corners of the object rounded
        cornerRadius(for: emailTextField)
        cornerRadius(for: firstNameTextField)
        cornerRadius(for: lastNameTextField)
        cornerRadius(for: passwordTextField)
        cornerRadius(for: birthdayTextField)
        
        cornerRadius(for: emailContinueButton)
        cornerRadius(for: fullNameContinueButton)
        cornerRadius(for: passwordContinueButton)
        cornerRadius(for: birthdayContinueButton)
        
        //apply padding to the textFields
        
        padding(for: emailTextField)
        padding(for: firstNameTextField)
        padding(for: lastNameTextField)
        padding(for: passwordTextField)
        padding(for: birthdayTextField)
        
        //run function of configuration
        configure_footerView()
        
        //implement datePicker into birthdayTextField
        datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Calendar.current.date(byAdding: .year, value: -5, to: Date())
        datePicker.addTarget(self, action: #selector(self.datePickerDidChange(_:)), for: .valueChanged) //whenever the value has changed, the function will be executed.
        birthdayTextField.inputView = datePicker
        
        // implementation of swipe gesture
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(self.handle(_:)))
        swipe.direction = .right
        self.view.addGestureRecognizer(swipe)
        
        
        

        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() { //autolayout
        super.viewDidLayoutSubviews()
        
        DispatchQueue.main.async {
            //run function to configure the appearance
            //making corners rounded
            self.configure_button(gender: self.maleGenderButton)
            self.configure_button(gender: self.femaleGenderButton)
        }
        
    }
    
    //will make corners rounded for any views (objects)
    func cornerRadius(for view: UIView) {
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
    }
    
    //called everytime when the text field gets chenged
    @IBAction func textFieldDidChange(_ textField: UITextField) {
        
        // declaring constant (shortcut) to the Helper Class
        let helper = Helper()
        
        // logic for Email TextField
        if textField == emailTextField {
            
            // check email validation
            if helper.isValid(email: emailTextField.text!) {
                emailContinueButton.isHidden = false
            }
            
            // logic for First Name or Last Name TextFields
        } else if textField == firstNameTextField || textField == lastNameTextField {
            
            // check fullname validation
            if helper.isValid(name: firstNameTextField.text!) && helper.isValid(name: lastNameTextField.text!) {
                fullNameContinueButton.isHidden = false
            }
            
            // logic for Password TextField
        } else if textField == passwordTextField {
            
            // check password validation
            if passwordTextField.text!.count >= 6 {
                passwordContinueButton.isHidden = false
            }
        }
    
       
        
    }

    
    
    
    //add blank view tothe left side of the TextField (act like a blank gap)
    func padding(for textField: UITextField) {
        
        let blankView = UIView.init(frame: CGRect(x: 0, y: 0, width: 10, height: 20))
        textField.leftViewMode = .always
        
    }
    
    func configure_footerView() {
        
        //add the line at the top of the footerView
        let topLine = CALayer()
        topLine.borderWidth = 1
        topLine.borderColor = UIColor.lightGray.cgColor
        topLine.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 1)
        
        footerView.layer.addSublayer(topLine)
    }
    
    //configuring the appearance of gender buttons
    func configure_button(gender button: UIButton) {
        
        //creating constant with name border which is of type CALayer, it can executes functions of CALayer class
        
        let border = CALayer()
        border.borderWidth = 1.5
        border.borderColor = UIColor.lightGray.cgColor
        border.frame = CGRect(x: 0, y: 0, width: button.frame.width, height: button.frame.height)
        
        //Assign the layter created to the bnutton
        button.layer.addSublayer(border)
        
        //making borders rounded
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        
    }
    
    
    //called once these buttons are pressed
    @IBAction func emailContinueButton_clicked(_ sender: Any) {
        
        //move scrollView horizontally (by X to the width of the screen as a pointer).
        let position = CGPoint(x: self.view.frame.width, y: 0)
        scrollView.setContentOffset(position, animated: true)
//        let helper = Helper()
//        if helper.isValid(email: emailTextField.text!) {
//            print("VALID")
//        } else {
//            print("INVALID")
//        }
        
        //show new keyboard of next textField
        if firstNameTextField.text!.isEmpty {
            firstNameTextField.becomeFirstResponder()
        } else if lastNameTextField.text!.isEmpty {
            lastNameTextField.becomeFirstResponder()
        } else if firstNameTextField.text!.isEmpty == false && lastNameTextField.text!.isEmpty == false {
            firstNameTextField.resignFirstResponder()
            lastNameTextField.resignFirstResponder() 
        }
        
        
    }
    
    @IBAction func fullnameContinueButton_clicked(_ sender: Any) {
        //move scrollView horizontally (by 2*X to the width of the screen as a pointer).
        let position = CGPoint(x: self.view.frame.width * 2, y: 0)
        scrollView.setContentOffset(position, animated: true)
        
        if passwordTextField.text!.isEmpty {
            passwordTextField.becomeFirstResponder()
            
        } else if passwordTextField.text!.isEmpty == false {
            passwordTextField.becomeFirstResponder()
        }
    }
    
    @IBAction func passwordContinueButton_clicked(_ sender: Any) {
        //move scrollView horizontally (by 2*X to the width of the screen as a pointer).
        let position = CGPoint(x: self.view.frame.width * 3, y: 0)
        scrollView.setContentOffset(position, animated: true)
        
        if birthdayTextField.text!.isEmpty {
            birthdayTextField.becomeFirstResponder()
        } else if birthdayTextField.text!.isEmpty == false  {
            birthdayTextField.resignFirstResponder()
            //
            birthdayContinueButton.resignFirstResponder()
        }
    }
    
    //will be executed whenever any date is selected
    @objc func datePickerDidChange(_ datePicker: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateStyle = DateFormatter.Style.medium
        birthdayTextField.text = formatter.string(from: datePicker.date)
        
        let compareDateFormatter = DateFormatter()
        compareDateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
        
        // declaring the format of date, then to place a dummy date into this format
        let compareDate = compareDateFormatter.date(from: "2013/01/01 00:01")
        
        //if user is older than five years, show continue button
        if datePicker.date < compareDate! {
            birthdayContinueButton.isHidden = false
        }
    }
    
    @IBAction func birthdayContinueButton_clicked(_ sender: Any) {
        //move scrollView horizontally (by 2*X to the width of the screen as a pointer).
        let position = CGPoint(x: self.view.frame.width * 4, y: 0)
        scrollView.setContentOffset(position, animated: true)
    }
    
    //called once Swiped to the direction right <-
    @objc func handle(_ gesture: UISwipeGestureRecognizer) {
        //print("Swiped")
        
        
        //get the current position of the scrollView (horizontal position
        let current_x = scrollView.contentOffset.x
        ///get the width of the screen
        let screen_width = self.view.frame.width
        
        let new_x  = CGPoint(x: current_x - self.view.frame.width, y: 0)
        scrollView.setContentOffset(new_x, animated: true)
        
        if current_x > 0 {
            scrollView.setContentOffset(new_x, animated: true)
        }
        
    }
    
    //called when the screen is tapped (outside of any object)
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //stop all editings. HIde keyboard
        emailTextField.resignFirstResponder()
        firstNameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        birthdayTextField.resignFirstResponder()
    }
    
    //This function is executed whenever male/female button has been clicked
    @IBAction func genderButton_clicked(_ sender: UIButton) {
        
        //STEP 1: eclaring URL of the request; declaring the body to the URL; declaring the request with the safest method  - POST, that no one can grab our info
        let url = URL(string: "http://localhost/tb/register.php"
        )
        let body = "email=\(emailTextField.text!.lowercased())&firstName=\(firstNameTextField.text!.lowercased())&lastName=\(lastNameTextField.text!.lowercased())&password=\(passwordTextField.text!)&birthday=\(datePicker.date)&gender=\(sender.tag)"
        print(body)
        var request = URLRequest(url: url!)
        request.httpBody = body.data(using: .utf8)
        request.httpMethod = "POST"
        //STEP 2. Execute created above request
        URLSession.shared.dataTask(with: request) {(data, response, error) in
            
            let helper = Helper()
            if error != nil {
                helper.showAlert(title: "Server error", message: error!.localizedDescription, from: self)
                return
            }
            
            //fetch JSON from server
            do {
                
                //safe mode of casting data
                guard let data = data else {
                    helper.showAlert(title: "Data Error", message: error!.localizedDescription, from: self)
                    return
                }
                
                //fetching JSON
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSDictionary
                
                print(json)
                
               
            //error while fetchig JSON
            } catch {
                helper.showAlert(title: "JSON Error", message: error.localizedDescription, from: self)
                
            }
            
            
            
        }.resume()
        
    }
    
    
    
    
    // executed once any CANCEL (Dismissing) button has been pressed
    @IBAction func cancelButton_clicked(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    
}

