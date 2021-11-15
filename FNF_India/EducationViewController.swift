//
//  EducationViewController.swift
//  FNF_India
//
//  Created by mercurius solutions pvt ltd on 05/03/20.
//  Copyright © 2020 mercurius solutions pvt ltd. All rights reserved.
//

import UIKit

class EducationViewController: BaseViewController {

    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var cardView: UIStackView!
     var cardCount: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Education Details"
       
        addCardview()
        addCardview()
        addCardview()
        buttonShadow(button: submitButton)

        // Do any additional setup after loading the view.
    }
    @IBAction func addbuttonAction(_ sender: Any) {
    
        cardCount += 1
        addEducationDetails(index: cardCount)
        
        
    }
    
    @IBAction func submitButtonAction(_ sender: Any) {
        
        for i in 0..<cardView.arrangedSubviews.count {
            let view = cardView.arrangedSubviews[i] as! AddCardView
            print(view.certificateType.text,"certificatetype")
            print(view.courseType.text,"coursetype")
            if (view.certificateType.text!.isEmpty || view.courseType.text!.isEmpty || view.certificateType.text!.isEmpty || view.aggregate.text!.isEmpty) {
                alertAction(title: "Warning", message: "Please fill the required fields")
            }
        }
    }
    
    func addEducationDetails(index : Int) {
        if index <= 3 {
            let newView = AddCardView()
            cardView.addArrangedSubview(newView)
        }
        else {
            alertAction(title: "Warning", message: "You cannot add more than 3 education details")
        }
    }
    func addCardview() {
        let firstView = AddCardView()
               cardView.addArrangedSubview(firstView)
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
