//
//  EmergencyAndOtherDetailsViewController.swift
//  FNF_India
//
//  Created by mercurius solutions pvt ltd on 16/03/20.
//  Copyright © 2020 mercurius solutions pvt ltd. All rights reserved.
//
//import MBRadioCheckboxButton
import UIKit

class EmergencyAndOtherDetailsViewController: BaseViewController {
//    @IBOutlet weak var yesRadioButton: RadioButton!
//    
//    @IBOutlet weak var noRadioButton: RadioButton!
//    @IBOutlet weak var husbandRadioButton: RadioButton!
//    @IBOutlet weak var fatherRadioButton: RadioButton!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var contactPerson: UITextField!
    @IBOutlet weak var contactNo: UITextField!
    @IBOutlet weak var Relation: UITextField!
    @IBOutlet weak var fatherOrHusbandname: UITextField!
    let preferences = UserDefaults.standard
    var fatherOrHusband = 1
    var previousInterview = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonShadow(button: submitButton)
        self.navigationItem.title = "Personal Details"
//        bottomRounderCorner(view: navbarView)

        // Do any additional setup after loading the view.
    }
    
    @IBAction func fatherTapped(_ sender: Any) {
        fatherOrHusband = 1
    }
    
    @IBAction func husbandTapped(_ sender: Any) {
        fatherOrHusband = 0
    }
    
    
    @IBAction func yesTapped(_ sender: Any) {
        previousInterview = 0
    }
    
    @IBAction func noTapped(_ sender: Any) {
        previousInterview = 1
    }
    func postData() {
        guard let emailId = preferences.string(forKey: "email") else {
                   return
               }
        print(emailId,"email")
        guard let candidate = preferences.string(forKey: "candidateType") else {
            return
        }
        let candidateType = Int(candidate)!
        print(candidateType)
        guard let firstName = preferences.string(forKey: "name") else {
                   return
               }
        print(firstName,"firstName")
        guard let middleName = preferences.string(forKey: "middleName") else {
            return
        }
        print(middleName,"middleName")
        guard let lastName = preferences.string(forKey: "lastName") else {
            return
        }
        print(lastName,"lastName")
//        guard let dob = preferences.string(forKey: "dob") else {
//            return
//        }
        guard let aadharNo = preferences.string(forKey: "aadharNo") else {
            return
        }
        print(aadharNo,"aadhar")
        guard let genderString = preferences.string(forKey: "gender") else {
            return
        }
        let gender = Int(genderString)!
        print(gender,"gender")
        guard let presentAddress = preferences.string(forKey: "presentAddresss") else {
            return
        }
        print(presentAddress,"address")
        guard let city = preferences.string(forKey: "city") else {
            return
        }
        let stateId = 2
        print(stateId,"stateId")
        guard let stateString = preferences.string(forKey: "state") else {
            return
        }
        print(stateString,"state")
        let stateIndex = Int(stateString)!
        guard let pincode = preferences.string(forKey: "pincode") else {
            return
        }
        print(pincode,"pin")
        guard let periodOfStayFrom = preferences.string(forKey: "periodOfStayFrom") else {
            return
        }
        print(periodOfStayFrom,"periodFrom")
        guard let periodOfStayTo = preferences.string(forKey: "periodOfStayTo") else {
            return
        }
        print(periodOfStayTo,"periodTo")
        guard let landline = preferences.string(forKey: "landline") else {
                   return
               }
        print(landline,"landline")
        guard let mobile = preferences.string(forKey: "mobile") else {
                   return
               }
        print(mobile,"mobile")
        guard let isDisabledString = preferences.string(forKey: "isDisabled") else {
                          return
                      }
        let isDisabled = Int(isDisabledString)!
        print(isDisabled,"isDisabled")
        guard let disabilityRemarks = preferences.string(forKey: "disabilityDetails") else {
                          return
                      }
        print(disabilityRemarks,"remarks")
        guard let emergencyContactPerson = contactPerson.text else {
            return
        }
        print(emergencyContactPerson,"person")
        guard let emergencyConatctNumber = contactNo.text else {
            return
        }
        print(emergencyConatctNumber,"emergencyContact")
        guard let emergencyContactRelation = Relation.text else {
            return
        }
        print(emergencyContactRelation,"relation")
        guard let fatherOrhusbandNameText = fatherOrHusbandname.text else {
            return
        }
        print(fatherOrhusbandNameText,"fatherName")
        
        let url = URL(string: "http://192.168.25.5/fnf/Update_final.php?email_id="+emailId)!
              var request = URLRequest(url: url)
                  request.httpMethod = "POST"
        
        
         let parameters: [String: Any] = ["first_name" : firstName,
                                                 "email_id" : emailId,
                                                 "middle_name":middleName,
                                                 "last_name" : lastName,
                                                 "mobile_number" : mobile,
                                                 "aadhar_no" : aadharNo,
                                                 "present_address" : presentAddress,
                                                 "place" : city,
                                                 "present_pincode" : pincode,
                                                 "present_from" : periodOfStayFrom,
                                                 "present_to" : periodOfStayTo,
                                                 "emergency_contact_no" : emergencyConatctNumber,
                                                 "present_landline" : landline,
                                                 "present_mobile_number" : mobile,
                                                 "emergency_contact_relation" : emergencyContactRelation ,
                                                 "candidate_type" : candidateType,
                                                 "emergency_contact" : emergencyContactPerson,
                                                 "present_stateId" : stateIndex,
                                                "previousinterview" : previousInterview,
                                                "is_disabled" : isDisabled,
                                                 "disability_remarks" : disabilityRemarks,
                                                 "fatherorhusband" : fatherOrHusband,
                                                 "gender" : gender,
                                                 "father_husband_name": fatherOrhusbandNameText]
        //                                         "dob" : now]
        //                                         ]
        request.httpBody = parameters.percentEncoded()
        
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
    

    @IBAction func submitButtonAction(_ sender: Any) {
//        postData()
//
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let welcomeVC = storyboard.instantiateViewController(withIdentifier: "educationDetailsVC") as! EducationViewController

        self.navigationController?.pushViewController(welcomeVC, animated: true)
        
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
