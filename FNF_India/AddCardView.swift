//
//  AddCardView.swift
//  FNF_India
//
//  Created by mercurius solutions pvt ltd on 05/03/20.
//  Copyright © 2020 mercurius solutions pvt ltd. All rights reserved.
//

import UIKit

class AddCardView: UIView,UIPickerViewDelegate,UIPickerViewDataSource {
    
    

    @IBOutlet var containerView: UIView!
    @IBOutlet weak var certificateType: UITextField!
    @IBOutlet weak var courseType: UITextField!
    @IBOutlet weak var enrollmentNumber: UITextField!
    @IBOutlet weak var universityName: UITextField!
    @IBOutlet weak var schoolName: UITextField!
    @IBOutlet weak var schoolAddress: UITextField!
    @IBOutlet weak var yearOfPassing: UITextField!
    @IBOutlet weak var aggregate: UITextField!
    @IBOutlet weak var schoolContact: UITextField!
    @IBOutlet weak var major: UITextField!
    var picker = UIPickerView()
    var toolBar = UIToolbar()
    var datePicker = UIDatePicker()
    var certificateArray = ["X","XII","B Tech","B Com","BBA","BCA","BSC"]
    var courseTypeArray = ["Full Time","Part Time","Correspondance"]
    
    override init(frame: CGRect) {
           super.init(frame: frame)
           commonInit()
       }
       
       required init?(coder: NSCoder) {
           super.init(coder: coder)
           
           commonInit()
       }
       
       private func commonInit() {
           Bundle.main.loadNibNamed("AddCardView", owner: self, options: nil)
           addSubview(containerView)
           containerView.frame = self.bounds
           containerView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        picker.delegate = self
        picker.dataSource = self
        datePicker.datePickerMode = .date
        setupToolbar()
        certificateType.inputView = picker
        certificateType.inputAccessoryView = toolBar
        
        courseType.inputView = picker
        courseType.inputAccessoryView = toolBar
        
        yearOfPassing.inputView = datePicker
        yearOfPassing.inputAccessoryView = toolBar
        
        let bottomArrow = UIImage(named: "downArrow_icon")
        let calendarImage = UIImage(named: "calendar_icon")
        addRightImageTo(textField: certificateType, image: bottomArrow!)
        addRightImageTo(textField: courseType, image: bottomArrow!)
        addRightImageTo(textField: yearOfPassing, image: calendarImage!)
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
            if yearOfPassing.isFirstResponder {
                datePicker.datePickerMode = UIDatePicker.Mode.date
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd-MM-yyyy"
                let selectedDate = dateFormatter.string(from: datePicker.date)
                yearOfPassing.text = selectedDate
            }
            else if certificateType.isFirstResponder{
                let row = self.picker.selectedRow(inComponent: 0)
                self.picker.selectRow(row, inComponent: 0, animated: false)
                certificateType.text = certificateArray[row]
//                candidateTypeIndex = row + 1
            }
            else if courseType.isFirstResponder {
                let row = self.picker.selectedRow(inComponent: 0)
               self.picker.selectRow(row, inComponent: 0, animated: false)
               courseType.text = courseTypeArray[row]
//               genderIndex = row + 1
            }
            self.endEditing(true)
        }
        
         @objc func didTapCancel() {
        //        self.sourceTextfield.text = nil
        //        self.sourceTextfield.resignFirstResponder()
                   self.endEditing(true)
            }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if certificateType.isFirstResponder {
            return certificateArray.count
        }
        else if courseType.isFirstResponder {
            return courseTypeArray.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if certificateType.isFirstResponder {
                   return  certificateArray[row]
               }
        else if courseType.isFirstResponder {
                   return courseTypeArray[row]
               }
        return nil
       
    }
    
    func addRightImageTo(textField : UITextField, image : UIImage) {
        let rightImageView = UIImageView(frame: CGRect(x: 0, y: 0
            , width: image.size.width, height: image.size.height))
        rightImageView.image = image
        textField.rightView = rightImageView
        textField.rightViewMode = .always
    }

    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
