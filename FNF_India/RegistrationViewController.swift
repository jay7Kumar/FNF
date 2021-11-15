//
//  RegistrationViewController.swift
//  FNF_India
//
//  Created by mercurius solutions pvt ltd on 02/03/20.
//  Copyright © 2020 mercurius solutions pvt ltd. All rights reserved.
//

import UIKit

class RegistrationViewController: BaseViewController,UIPickerViewDelegate,UIPickerViewDataSource {
   
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var mobileNumber: UITextField!
    
    @IBOutlet weak var sourceName: UITextField!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var sourceTextfield: UITextField!
    @IBOutlet weak var consultantTextfield: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    let preferences = UserDefaults.standard
    let sourceArray = ["Consultant","Contract Staff","Employee Reference","Job Portals","Advertisments"]
    let consultantArray = ["Whyflex"]
    var picker = UIPickerView()
    var toolBar = UIToolbar()
    var sourceIndex = 0
   
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        buttonShadow(button: submitButton)
        
        headerView.clipsToBounds = true
        headerView.layer.cornerRadius = 14
        headerView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        
        let bottomArrow = UIImage(named: "downArrow_icon")
        addRightImageTo(textField: sourceTextfield, image: bottomArrow!)
        addRightImageTo(textField: consultantTextfield, image: bottomArrow!)
        
        
//        picker = UIPickerView(frame: CGRect(x: 0, y: 200, width: view.frame.width, height: 200))
//        picker.backgroundColor = UIColor.white

//        picker.showsSelectionIndicator = true
        picker.delegate = self
        picker.dataSource = self
 
        setupToolbar()
        sourceTextfield.inputView = picker
        sourceTextfield.inputAccessoryView = toolBar
        consultantTextfield.inputView = picker
        consultantTextfield.inputAccessoryView = toolBar

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
         AppUtility.lockOrientation(.portrait)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
//         AppUtility.lockOrientation(.all)
    }
   
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
           return 1
       }
       
       func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if sourceTextfield.isFirstResponder {
            return sourceArray.count
        }
        else if consultantTextfield.isFirstResponder {
            return consultantArray.count
        }
        return 0
        
       }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if sourceTextfield.isFirstResponder {
                   return  sourceArray[row]
               }
               else if consultantTextfield.isFirstResponder {
                   return consultantArray[row]
               }
        return nil
       
    }
    
    
    
    
    func setupToolbar(){
//        let barAccessory = UIToolbar(frame: CGRect(x: 0, y: 0, width: picker.frame.width, height: 44))
        toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44))
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 0/255, green: 122/255, blue: 1, alpha: 1)
        toolBar.sizeToFit()

        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.donePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.didTapCancel))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
    }
    
//    func buttonShadow(){
//        submitButton.layer.cornerRadius = 6
//        submitButton.layer.shadowColor = UIColor.black.cgColor
//        submitButton.layer.shadowOffset = CGSize(width: 2, height: 2);
//        submitButton.layer.shadowOpacity = 0.25
//        submitButton.layer.shadowRadius = 2
//        submitButton.layer.masksToBounds = false
//    }

    @objc func donePicker () {
        let row = self.picker.selectedRow(inComponent: 0)
        self.picker.selectRow(row, inComponent: 0, animated: false)
        if sourceTextfield.isFirstResponder {
            self.sourceTextfield.text = self.sourceArray[row]
            sourceIndex = row + 1
        }
        else if consultantTextfield.isFirstResponder {
            consultantTextfield.text = consultantArray[row]
        }
        
        self.sourceTextfield.resignFirstResponder()
        self.view.endEditing(true)
    }
    
    
    
    
//    func didTapDone() {
//        let row = self.pickerView.selectedRow(inComponent: 0)
//        self.pickerView.selectRow(row, inComponent: 0, animated: false)
//        self.textView.text = self.titles[row]
//        self.textField.resignFirstResponder()
//    }

    @objc func didTapCancel() {
           self.view.endEditing(true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func insertValues(){
        
        let url = URL(string: "http://192.168.25.5/fnf/registration.php")
        var request = URLRequest(url: url!)
                     request.httpMethod = "POST"
        guard let firstName = name.text else {
            return
        }
        guard let emailId = email.text else {
            return
        }
        guard let mobile = mobileNumber.text else {
            return
        }
        guard let sourceNameText = sourceName.text else {
            return
        }
        let postString = "first_name=\(String(describing: firstName))&email_id=\(emailId)&mobile_number=\(mobile)&source_id=\(sourceIndex)&source_name=\(sourceNameText)"
    
        request.httpBody = postString.data(using:String.Encoding.utf8)

        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in

            if error != nil {
                print("error=\(String(describing: error))")
                return
            }
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("Server error!")
                return
            }
            do {
                   let json = try JSONSerialization.jsonObject(with: data!, options: [])
                   
                   print (json)
                   
                   guard let jsonArray = json as? [String: Any] else {
                         return
                   }
                   
                   if jsonArray["message"] as! String != "success" {
                    print("sucess")
                       return
                   }
            }
            catch {
                print("JSON error: \(error.localizedDescription)")
            }
        }
        task.resume()
        

    }

    @IBAction func submitButtonAction(_ sender: Any) {
       
//        if (name.text!.isEmpty || email.text!.isEmpty || mobileNumber.text!.isEmpty || sourceTextfield.text!.isEmpty || sourceName.text!.isEmpty) {
////            name.layer.borderColor = UIColor.red.cgColor
////            name.layer.borderWidth = 1
////            name.layer.cornerRadius = 2
//            alertAction(title: "Warning", message: "Please fill the required fields")
//        }
//        else if (mobileNumber.text!.count < 10) || (mobileNumber.text!.count > 10) {
//            alertAction(title: "Warning", message: "Please enetr a valid 10 digit mobile number")
//        }
//        else if !isValidEmail(email.text!) {
////            let bottomArrow = UIImage(named: "warning")
////            addRightImageTo(textField: email, image: bottomArrow!)
//            alertAction(title: "Warning", message: "Please enter a valid email")
//        }
//        else {
        preferences.set(email.text, forKey: "email")
            insertValues()
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let welcomeVC = storyboard.instantiateViewController(withIdentifier: "welcomeVC") as! WelcomeViewController

            self.navigationController?.pushViewController(welcomeVC, animated: true)
        

        
        
    }
}


