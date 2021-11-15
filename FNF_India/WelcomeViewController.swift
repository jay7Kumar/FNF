//
//  WelcomeViewController.swift
//  FNF_India
//
//  Created by mercurius solutions pvt ltd on 03/03/20.
//  Copyright © 2020 mercurius solutions pvt ltd. All rights reserved.
//

import UIKit

class WelcomeViewController: BaseViewController {

    @IBOutlet weak var autonomyLabel: UILabel!

    @IBOutlet weak var navbarView: UIView!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var biasLabel: UILabel!
    let preferences = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        AppUtility.lockOrientation(.portrait)
        buttonShadow(button: continueButton)
        bottomRounderCorner(view: navbarView)
       
//        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.navigationBar.isHidden = false

        self.navigationItem.title = "Welcome"
        let boldText = "Autonomy and Entrepreneurship-"
        let attrs = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16)]
        let attributedString = NSMutableAttributedString(string:boldText, attributes:attrs)

        let normalText = " employees are provided levels of authority based on their responsibilities, then empowered to make decisions and resolveproblems as close as possible to the point of client contact."
        let normalString = NSMutableAttributedString(string:normalText)

        attributedString.append(normalString)
        
        let boldText1 = "Bias for Action-"
        let attrs1 = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16)]
        let attributedString1 = NSMutableAttributedString(string:boldText1, attributes:attrs)

        let normalText1 = " employees analyze tasks, reach decisions and implement solutions as soon as possible, challenging all assumptions and striving for continuous improvement."
        let normalString1 = NSMutableAttributedString(string:normalText1)

        attributedString1.append(normalString1)
        autonomyLabel.attributedText = attributedString
//        autonomyLabel
        biasLabel.attributedText = attributedString1
//        fetchData()
       
    }
    override func viewWillAppear(_ animated: Bool) {
         AppUtility.lockOrientation(.portrait)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
//        AppUtility.lockOrientation(.all)
    }
    @IBAction func continuebuttonAction(_ sender: Any) {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let authenticationVC = storyboard.instantiateViewController(withIdentifier: "authenticationVC") as! AuthenticationViewController
//
//        self.navigationController?.pushViewController(authenticationVC, animated: true)
    }
    
    func fetchData() {
        guard let emailId = preferences.string(forKey: "email") else {
                   return
               }
        guard let url = URL(string: "http://192.168.25.5/fnf/fetch_final.php?email_id="+emailId) else {
            return
        }
        print(url,"@@@@@@@")
        let task = URLSession.shared.dataTask(with: url) {(data,response,error) in
            guard let dataResponse = data, error == nil else {
                print(error?.localizedDescription ?? "Response Error")
                return
            }
            do {
                let jsonresponse = try JSONSerialization.jsonObject(with: dataResponse, options: [])
                print(jsonresponse)
            } catch let parsingError {
                print("Error",parsingError)
            }
        }
        task.resume()
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
