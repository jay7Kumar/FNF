//
//  SignatureViewController.swift
//  FNF_India
//
//  Created by mercurius solutions pvt ltd on 03/03/20.
//  Copyright © 2020 mercurius solutions pvt ltd. All rights reserved.
//

import UIKit

class SignatureViewController: UIViewController,YPSignatureDelegate {

    @IBOutlet weak var signatureView: YPDrawSignatureView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var eraseButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    var didSign = false
    override func viewDidLoad() {
        super.viewDidLoad()
        signatureView.delegate = self
       
       

//        let value = UIInterfaceOrientation.landscapeLeft.rawValue
//        UIDevice.current.setValue(value, forKey: "orientation")
      
//         AppUtility.lockOrientation(.landscapeLeft)
        
        eraseButton.setImage(UIImage(named: "erase_icon"), for: .normal)
        eraseButton.imageEdgeInsets = UIEdgeInsets(top: 3, left: 0, bottom: 0, right: 8)
        
        cancelButton.setImage(UIImage(named: "cancel_icon"), for: .normal)
        cancelButton.imageEdgeInsets = UIEdgeInsets(top: 3, left: 0, bottom: 0, right: 8)
        
        saveButton.setImage(UIImage(named: "save_icon"), for: .normal)
        saveButton.imageEdgeInsets = UIEdgeInsets(top: 3, left: 0, bottom: 0, right: 8)
//         UIGraphicsBeginImageContext(self.signatureView.frame.size)
//            UIImage(named: "signature_bg")?.draw(in: self.view.bounds)
//            let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
//            UIGraphicsEndImageContext()
//            self.signatureView.backgroundColor = UIColor(patternImage: image)
        eraseButton.layer.cornerRadius = 4
        cancelButton.layer.cornerRadius = 4
        saveButton.layer.cornerRadius = 4
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        AppUtility.lockOrientation(.landscapeLeft, andRotateTo: .landscapeRight)
         self.navigationController?.navigationBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        AppUtility.lockOrientation(.portrait, andRotateTo: .portrait)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    func didStart(_ view: YPDrawSignatureView) {
        didSign = true
    }
    func didFinish(_ view: YPDrawSignatureView) {
        didSign = true
    }
    
    @IBAction func eraseButtonAction(_ sender: Any) {
        signatureView.clear()
    }
    
    @IBAction func saveButtonAction(_ sender: Any) {
        if let signature = self.signatureView.getCroppedSignature() {
            let imageDataDict:[String: UIImage] = ["image": signature]
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "notificationName"), object: nil, userInfo: imageDataDict)
            self.navigationController?.popViewController(animated: true)
            
        }
        
       
    }
    //    override var shouldAutorotate: Bool {
//        return false
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

