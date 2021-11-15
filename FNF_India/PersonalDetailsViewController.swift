//
//  PersonalDetailsViewController.swift
//  FNF_India
//
//  Created by mercurius solutions pvt ltd on 04/03/20.
//  Copyright © 2020 mercurius solutions pvt ltd. All rights reserved.
//

import UIKit
//import MBRadioCheckboxButton


class PersonalDetailsViewController: BaseViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    
    
    @IBOutlet weak var fathersNameTextfield: UITextField!
    @IBOutlet weak var dateOfBirthTextfield: UITextField!
    
    @IBOutlet weak var disabilityView: UIView!
    @IBOutlet weak var dateTextfield: UITextField!
    //    @IBOutlet weak var yesButton: RadioButton!
//    @IBOutlet weak var noButton: RadioButton!
//    @IBOutlet weak var husbandButton: RadioButton!
//    @IBOutlet weak var fatherButton: RadioButton!
    
    @IBOutlet weak var disabilityDetails: UITextField!
    @IBOutlet weak var speciallyAbled: UITextField!
    @IBOutlet weak var mobile: UITextField!
    @IBOutlet weak var landline: UITextField!
    @IBOutlet weak var periodOfStayTo: UITextField!
    @IBOutlet weak var periodOfStayFrom: UITextField!
    @IBOutlet weak var pincode: UITextField!
    @IBOutlet weak var state: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var presentAddress: UITextField!
    @IBOutlet weak var gender: UITextField!
    @IBOutlet weak var aadharNo: UITextField!
    @IBOutlet weak var age: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var middleName: UITextField!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var candidatetypeTextfield: UITextField!
    @IBOutlet weak var navbarView: UIView!
    @IBOutlet weak var submitButton: UIButton!
    let candidateArray = ["Fresher","Experienced"]
    let genderArray = ["Male","Female","Others"]
    let stateArray = ["Andhra Pradesh","Arunachal Pradesh","Assam","Bihar","Chattisgarh","Goa","Gujarat","Haryana","Himachal Pradesh","Jammu and Kashmir","Jharkhand","Karnataka","Kerala","Madhya Pradesh","Maharastra","Manipur","Meghalaya","Mizoram","Nagaland","Odisha","Punjab","Rajasthan","Sikkim","Tamil Nadu","Telangana","Tripura","Uttar Pradesh","Uttrakhand","West Bengal"]
    let disabilityArray = ["Yes","No"]
     let preferences = UserDefaults.standard
    var candidateTypeIndex = 0
    var genderIndex = 0
    var stateIndex = 0
    var disabilityIndex = 0

//    var radioContainer = RadioButtonContainer()
    
    var picker = UIPickerView()
    var toolBar = UIToolbar()
    var datePicker = UIDatePicker()
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonShadow(button: submitButton)
        bottomRounderCorner(view: navbarView)
//        radioContainer.addButtons([fatherButton,husbandButton])
        
        let bottomArrow = UIImage(named: "downArrow_icon")
        addRightImageTo(textField: candidatetypeTextfield, image: bottomArrow!)
        
        let calendarImage = UIImage(named: "calendar_icon")
        addRightImageTo(textField: dateTextfield, image: calendarImage!)
        addRightImageTo(textField: dateOfBirthTextfield, image: calendarImage!)
        self.navigationItem.title = "Personal Details"
        
        picker.showsSelectionIndicator = true
        picker.delegate = self
        picker.dataSource = self
        
        datePicker.datePickerMode = .date

        setupToolbar()
        candidatetypeTextfield.inputView = picker
        candidatetypeTextfield.inputAccessoryView = toolBar
        
        gender.inputView = picker
        gender.inputAccessoryView = toolBar
        
        state.inputView = picker
        state.inputAccessoryView = toolBar
        
        speciallyAbled.inputView = picker
        speciallyAbled.inputAccessoryView = toolBar
               
//        dateTextfield.inputView = datePicker
//        dateTextfield.inputAccessoryView = toolBar
        dateOfBirthTextfield.inputView = datePicker
        dateOfBirthTextfield.inputAccessoryView = toolBar
        
    

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        print(Date().string(format: "dd-MM-yyyy"),"DAte")
        
        dateTextfield.text = Date().string(format: "dd-MM-yyyy")
        dateTextfield.isUserInteractionEnabled = false
//        fetchData()
//        fetch()
    }
    
    
    func fetchData(){
        guard let emailId = preferences.string(forKey: "email") else {
            return
        }

        let url = URL(string: "http://192.168.25.5/fnf/fetch_final.php?email_id="+emailId)
        var request = URLRequest(url: url!)
                     request.httpMethod = "POST"

        let postString = "email_id=\(emailId)"

        request.httpBody = postString.data(using:String.Encoding.utf8)
        print(url,"*****")

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
            let responseString = String(data: data!, encoding: String.Encoding.utf8)
//            print(responseString)
           
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: []) 

                   print (json)

                   guard let jsonArray = json as? [String: Any] else {
                         return
                   }

                   if jsonArray["message"] as! String != "success" {
                       return
                   }
            }
            catch {
                print("JSON error: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
    
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if candidatetypeTextfield.isFirstResponder {
            return candidateArray.count
        }
        else if gender.isFirstResponder {
            return genderArray.count
        }
        else if state.isFirstResponder {
                return stateArray.count
            }
        else if speciallyAbled.isFirstResponder {
            return disabilityArray.count
        }
        return 0
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if candidatetypeTextfield.isFirstResponder {
            return candidateArray[row]
        }
        else if gender.isFirstResponder {
            return genderArray[row]
        }
        else if state.isFirstResponder {
            return stateArray[row]
                   }
        else if speciallyAbled.isFirstResponder {
            return disabilityArray[row]
        }
        return nil
    }
    func setupToolbar(){
        toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: picker.frame.width, height: 44))
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

    @objc func donePicker () {
        if dateOfBirthTextfield.isFirstResponder {
            datePicker.datePickerMode = UIDatePicker.Mode.date
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy"
            let selectedDate = dateFormatter.string(from: datePicker.date)
            dateOfBirthTextfield.text = selectedDate
        }
        else if candidatetypeTextfield.isFirstResponder{
            let row = self.picker.selectedRow(inComponent: 0)
            self.picker.selectRow(row, inComponent: 0, animated: false)
            candidatetypeTextfield.text = candidateArray[row]
            candidateTypeIndex = row + 1
        }
        else if gender.isFirstResponder {
            let row = self.picker.selectedRow(inComponent: 0)
           self.picker.selectRow(row, inComponent: 0, animated: false)
           gender.text = genderArray[row]
           genderIndex = row + 1
        }
        else if state.isFirstResponder {
                let row = self.picker.selectedRow(inComponent: 0)
               self.picker.selectRow(row, inComponent: 0, animated: false)
               state.text = stateArray[row]
               stateIndex = row + 1
            }
        else if speciallyAbled.isFirstResponder {
            let row = self.picker.selectedRow(inComponent: 0)
            self.picker.selectRow(row, inComponent: 0, animated: false)
            speciallyAbled.text = disabilityArray[row]
            if row == 1 {
                disabilityView.isHidden = true
            }
            else if row == 0 {
                disabilityView.isHidden = false
            }
            disabilityIndex = row + 1
        }
       
//        if dateTextfield.isFirstResponder {
//            self.dateTextfield.text = self.newArray[row]
//        }
//        else if dateOfBirthTextfield.isFirstResponder {
//            dateOfBirthTextfield.text = newArray[row]
//        }
//
//        self.dateTextfield.resignFirstResponder()
        self.view.endEditing(true)
    }
    
     @objc func didTapCancel() {
    //        self.sourceTextfield.text = nil
    //        self.sourceTextfield.resignFirstResponder()
               self.view.endEditing(true)
        }
    
    func postData(){
        guard let emailId = preferences.string(forKey: "email") else {
            return
        }

                guard let firstName = name.text else {
                    return
                }
                guard let middleName = middleName.text else {
                    return
                }
                guard let lastName = lastName.text else {
                    return
                }
//                guard let dob = dateOfBirthTextfield.text else {
//                    return
//                }
//                guard let candidateType = candidatetypeTextfield.text else {
//                    return
//                }
//                guard let fatherName = fathersNameTextfield.text else {
//                    return
//                }
        //        guard let emailId = preferences.string(forKey: "email") else {
        //                   return
        //               }
        let mobile = "329849009"
        let aadharNo = "a12323"
        let presentAddress = "dhfjdsfd"
        let place = "RCB"
        let picode = "560090"
        let presentFrom = "yesterday"
        let presentTo = "Tomorrow"
        let emergencyContact = "123456"
        let presentLandline = "5627315721"
        let presentMobile = "783648324"
        let emergencyContactRelation = "2343432"
        let emergencyContactPerson = "pikachuu"
        let candidateType = 1
        let presentStateId = 1
        let previousInterview = 2
        let isDisabled = 1
        let disabilityRemaRKS = "SDKJHF"
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let now = Date()
        print(now,"!!!!!!!!!!!")
//        let date = formatter.date(from: "12-04-2020")
//        print(date)
        let dob = 0
        let fatherOrhusband = 1
        let gender = 1
    
        let fatherHusbandName = "jsakdf"
    print(emailId,"*********")
        
        
       let url = URL(string: "http://192.168.25.5/fnf/Update_final.php?email_id="+emailId)!
       var request = URLRequest(url: url)
           request.httpMethod = "POST"
        
            let postString = "first_name=\(String(describing: firstName))&middle_name=\(middleName)&last_name=\(lastName)&email_id=\(emailId)&mobile_number=\(mobile)&aadhar_no=\(aadharNo)"

//        let postString = "first_name=\(String(describing: firstName))&middle_name=\(middleName)&last_name=\(lastName)"
//        +"&aadhar_no=\(aadharNo)" + "&present_address=\(presentAddress)" + "&place=\(place)" + "&present_pincode=\(picode)" + "&present_from=\(presentFrom)" + "&present_to=\(presentTo)" + "&emergency_contact_no=\(emergencyContact)" + "&present_landline=\(presentLandline)" + "&present_mobile_number=\(presentMobile)" + "&emergency_contact_relation=\(emergencyContactRelation)" + "&candidate_type=\(candidateType)" + "&emergency_contact=\(emergencyContactPerson)" + "&present_stateId=\(presentStateId)" + "&previousinterview=\(previousInterview)" + "&is_disabled=\(isDisabled)" + "&disability_remarks=\(disabilityRemaRKS)" + "&dob=\(dob)" + "&fatherorhusband=\(fatherOrhusband)" + "&gender=\(gender)" + "&father_husband_name=\(fatherHusbandName)"
        
        let parameters: [String: Any] = ["first_name" : firstName,
                                         "email_id" : emailId,
                                         "middle_name":middleName,
                                         "last_name" : lastName,
                                         "mobile_number" : mobile,
                                         "aadhar_no" : aadharNo,
                                         "present_address" : presentAddress,
                                         "place" : place,
                                         "present_pincode" : picode,
                                         "present_from" : presentFrom,
                                         "present_to" : presentTo,
                                         "emergency_contact_no" : emergencyContact,
                                         "present_landline" : presentLandline,
                                         "present_mobile_number" : presentMobile,
                                         "emergency_contact_relation" : emergencyContactRelation,
                                         "candidate_type" : candidateType,
                                         "emergency_contact" : emergencyContactPerson,
                                         "present_stateId" : presentStateId,
                                         "previousinterview" : previousInterview,
                                         "is_disabled" : isDisabled,
                                         "disability_remarks" : disabilityRemaRKS,
                                         "fatherorhusband" : fatherOrhusband,
                                         "gender" : gender,
                                         "father_husband_name" : fatherHusbandName]
//                                         "dob" : now]
//                                         ]
        
                                    
//
//
//
//
//
//
//
//
//                                         ]
       
        request.httpBody = parameters.percentEncoded()


       


       
//       request.httpBody = postString.data(using:String.Encoding.utf8)

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
                      return
                  }
           }
           catch {
               print("JSON error: \(error.localizedDescription)")
           }
       }
       task.resume()
    }
    
    func saveData() {
        preferences.set(candidateTypeIndex, forKey: "candidateType")
        preferences.set(name.text, forKey: "name")
        preferences.set(middleName.text, forKey: "middleName")
        preferences.set(lastName.text, forKey: "lastName")
//        preferences.set(dateOfBirthTextfield.text, forKey: "dob")
        preferences.set(aadharNo.text, forKey: "aadharNo")
        preferences.set(genderIndex, forKey: "gender")
        preferences.set(presentAddress.text, forKey: "presentAddresss")
        preferences.set(city.text, forKey: "city")
        print(stateIndex,"stateIndex")
        preferences.set(stateIndex, forKey: "state")
        preferences.set(pincode.text, forKey: "pincode")
        preferences.set(periodOfStayFrom.text, forKey: "periodOfStayFrom")
        preferences.set(periodOfStayTo.text, forKey: "periodOfStayTo")
        preferences.set(landline.text, forKey: "landline")
        preferences.set(mobile.text, forKey: "mobile")
        preferences.set(disabilityIndex, forKey: "isDisabled")
        preferences.set(disabilityDetails.text, forKey: "disabilityDetails")
       
    }
    
    @IBAction func submitButtonAction(_ sender: Any) {

//        saveData()
        if (candidatetypeTextfield.text!.isEmpty || name.text!.isEmpty || lastName.text!.isEmpty || dateOfBirthTextfield.text!.isEmpty || aadharNo.text!.isEmpty || gender.text!.isEmpty || presentAddress.text!.isEmpty || city.text!.isEmpty || state.text!.isEmpty || pincode.text!.isEmpty || speciallyAbled.text!.isEmpty)
        {
            alertAction(title: "Warning", message: "Please enter the required fields")
        }
        else {
        
         let storyboard = UIStoryboard(name: "Main", bundle: nil)
               let personalDetailsVC = storyboard.instantiateViewController(withIdentifier: "emergencyVC") as! EmergencyAndOtherDetailsViewController
        //
                self.navigationController?.pushViewController(personalDetailsVC, animated: true)
        }
//        postData()
        
//        guard let firstName = name.text else {
//            return
//        }
//        guard let middleName = middleName.text else {
//            return
//        }
//        guard let lastName = lastName.text else {
//            return
//        }
//        guard let dob = dateOfBirthTextfield.text else {
//            return
//        }
//        guard let candidateType = candidatetypeTextfield.text else {
//            return
//        }
//        guard let fatherName = fathersNameTextfield.text else {
//            return
//        }
//        guard let emailId = preferences.string(forKey: "email") else {
//                   return
//               }
       
        
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

extension Date {
    func string(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}


///
extension Dictionary {
    func percentEncoded() -> Data? {
        return map { key, value in
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            return escapedKey + "=" + escapedValue
        }
        .joined(separator: "&")
        .data(using: .utf8)
    }
}

extension CharacterSet {
    static let urlQueryValueAllowed: CharacterSet = {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="

        var allowed = CharacterSet.urlQueryAllowed
        allowed.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        return allowed
    }()
}
