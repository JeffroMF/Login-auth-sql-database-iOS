//
//  LoginVC.swift
//  Trybes v2
//
//  Created by Bruno Campos on 12/20/18.
//  Copyright © 2018 Bruno Campos. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    //UI objects
    //IBOutlet means that it is connected to a physical object in interface
    //weak variables: application will not keep memory for this variable if we leave this screen to another screen
    //strong will always keep the info in our app
    @IBOutlet weak var textFieldsView: UIView!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var leftLineView: UIView!
    
    @IBOutlet weak var rightLineView: UIView!
    
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var handsImageView: UIImageView!
    
    //constraint objects
    @IBOutlet weak var coverImageView_top: NSLayoutConstraint!
    @IBOutlet weak var whiteIconImageView_y: NSLayoutConstraint!
    @IBOutlet weak var handsImageView_top: NSLayoutConstraint!
    @IBOutlet weak var registerButton_bottom: NSLayoutConstraint!
    
    //cache initial values
    //cache objects
    var coverImageView_top_cache: CGFloat!
    var whiteIconImageView_y_cache: CGFloat!
    var handsImageView_top_cache: CGFloat!
    var registerButton_bottom_cache: CGFloat!
    
    
    
    
    //firstly executed function
    override func viewDidLoad() { // will be executed once the app
    //is loaded and the scene is presented to the user
        super.viewDidLoad()
        //caching all values of constraints
        coverImageView_top_cache = coverImageView_top.constant
        whiteIconImageView_y_cache = whiteIconImageView_y.constant
        handsImageView_top_cache = handsImageView_top.constant
        registerButton_bottom_cache = registerButton_bottom.constant
        
        //declaring notification observation in order to catch UIKeyboardWillShow / UIKeyboardWillHide Notification
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: Notification.Name.UIKeyboardWillShow, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: Notification.Name.UIKeyboardWillHide, object: nil)
    }
    
    // executed EVERYTIME when view did appear on the screen
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // declaring notification observation in order to catch UIKeyboardWillShow / UIKeyboardWillHide Notification
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: Notification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: Notification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
    
    // executed EVERYTIME when view did disappear from the screen
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // switch off notification center, so it wouldn't in action / running
        NotificationCenter.default.removeObserver(self)
        
        
    }
    
    
    //this function executes always when the screen's white space (excluding objects) is tapped
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //hide keyboards (end editing)
        self.view.endEditing(false)
    }
    
    //function to be ran once the keyboard is shown
    
    //executed once the keyboard is about to be shown
    @objc func keyboardWillShow(notification: Notification) {
        //Objective-C code: come on Bruno,
        //you can do it!
        //print("keyboardWillShow is executed") -> test
        
        
        
        //code to resize cover
        coverImageView_top.constant -= 75 //deduct from itself 75 pixels (Y axis). Doesn't actio
        handsImageView_top.constant -= 75
        whiteIconImageView_y.constant += 50
        
        
//        coverImageView_top.constant = -self.view.frame.width / 5.52
//
//        handsImageView_top.constant = -self.view.frame.width / 5.52
//        whiteIconImageView_y.constant = self.view.frame.width / 8.28
        
        //whiteIconImageView_y.constant += 25
        //whiteIconImageView_y.constant -= 50
        
        //we need to discover the size of the keyboard
        //if iOS app is able to access keyboard's frame, then change Y position of the Register button 
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            registerButton_bottom.constant += keyboardSize.height
            //registerButton_bottom.constant += keyboardSize.height
            //registerButton_bottom.constant = self.view.frame.width / 1.75423
        }
        
//        print("cover \(coverImageView_top.constant)")
//        print("hands \(handsImageView_top.constant)")
//        print("icon \(whiteIconImageView_y.constant)")
//        print("register button \(registerButton_bottom.constant)")
        
        
        
        UIView.animate(withDuration: 0.5) {
            //fade in animation -> toggle the alpha
            //self (MEANS) is the current class
            
            //here, we want the alpha to be 0 in order to animate
            self.handsImageView.alpha = 0
            self.view.layoutIfNeeded() //force to update the layout
        }
            //self.view.layoutIfNeeded()
    }
    
    //executed once the keyboard is about to be hidden
    @objc func keyboardWillHide(notification: Notification) {
        //print("keyboardWillHide is executed")
        coverImageView_top.constant = coverImageView_top_cache
        handsImageView_top.constant = handsImageView_top_cache
        whiteIconImageView_y.constant = whiteIconImageView_y_cache
        registerButton_bottom.constant = registerButton_bottom_cache
        
//        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
//            registerButton_bottom.constant = registerButton_bottom_cache
//        }
        
        //animation function. Whatever in the closures below will be animated
        UIView.animate(withDuration: 0.5) {
            self.handsImageView.alpha = 1
            
            //force to update the layout
            self.view.layoutIfNeeded()
        }
        
        
        
    }
    
    //executed after aligning the objects
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //call configure functions
        configure_loginBtn()
        configure_textFieldsView()
        configure_orLabel()
        configure_registerButton()
    }
    
    //configures appearance of the textFields' View
    func configure_textFieldsView(){
        
        
        
        
        //Declare constants to store info which later on will be assigned to certain so called objects
        let width = CGFloat(2)
        let color = UIColor.groupTableViewBackground.cgColor
        
        //Creating layer to be a border of the view
        let border = CALayer()
        border.borderWidth = width
        border.borderColor = color
        //declare frame for the border
        border.frame = CGRect(x: 0, y: 0, width: textFieldsView.frame.width, height: textFieldsView.frame.height)
        
        //Create layer to be a line in the center of the view
        let line = CALayer()
        line.borderWidth = width
        line.borderColor = color
        line.frame = CGRect(x: 0, y: textFieldsView.frame.height / 2 - width, width: textFieldsView.frame.width, height: width)
        
        //assigning created layers to the view
        textFieldsView.layer.addSublayer(border)
        textFieldsView.layer.addSublayer(line)
        
        //rounded corners (make it round by 5 pixels)
        textFieldsView.layer.cornerRadius = 5
        textFieldsView.layer.masksToBounds = true
    }
    
    //configure Login button appearance
    func configure_loginBtn() {
        //rounded corners
        loginButton.layer.cornerRadius = 5
        loginButton.layer.masksToBounds = true
        //loginButton.isEnabled = false
        
        
    }
    
    //configure appearance of OR label and its views storing the lines
    func configure_orLabel() {
        //create a left line, then a right line
        let width = CGFloat(2) //used in this function
        let color = UIColor.groupTableViewBackground.cgColor
        
        //create left line object (layer)
        let leftLine = CALayer()
        //create a width of left line, by assigning width and color values (constants)
        leftLine.borderWidth = width
        leftLine.borderColor = color
        //declare the size and frame of the color
        leftLine.frame = CGRect(x: 0, y: leftLineView.frame.height / 2 - width, width: leftLineView.frame.width, height: width)
        
        //Create right line object, by assigning width and color values edclared above (for shorter way)
        let rightLine = CALayer() //constant of type CALayer
        rightLine.borderWidth = width
        rightLine.borderColor = color
        rightLine.frame = CGRect(x: 0, y: rightLineView.frame.height / 2 - width, width: rightLineView.frame.width
            , height: width )
        
        //assign lines (layer objects) to UI object which are views
        
        leftLineView.layer.addSublayer(leftLine)
        rightLineView.layer.addSublayer(rightLine)
        
    }
    
    //will configure appearence of register button
    func configure_registerButton() {
        //create border
        //make border rounded
        
        //creating border constant named border of type layer which acts as a border frame
        let border = CALayer()
        border.borderColor = UIColor(red: 68/255, green: 105/255, blue: 176/255, alpha: 1).cgColor
        border.borderWidth = 2
        border.frame = CGRect(x: 0, y: 0, width: registerButton.frame.width, height: registerButton.frame.height)
        
        //assign created border to object (button)
        registerButton.layer.addSublayer(border)
        
        //rounded corner
        registerButton.layer.cornerRadius = 5
        registerButton.layer.masksToBounds = true
        
    }
    

    

}
