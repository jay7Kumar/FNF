//
//  BaseViewController.swift
//  FNF_India
//
//  Created by mercurius solutions pvt ltd on 02/03/20.
//  Copyright © 2020 mercurius solutions pvt ltd. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       let tapper = UITapGestureRecognizer(target: self, action:#selector(dismissKeyboard))
       tapper.cancelsTouchesInView = false
       view.addGestureRecognizer(tapper)
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    func alertAction(title : String , message : String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

        // Create the actions
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
            UIAlertAction in
            NSLog("OK Pressed")
        }
//        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
//            UIAlertAction in
//            NSLog("Cancel Pressed")
//        }

        // Add the actions
        alertController.addAction(okAction)
//        alertController.addAction(cancelAction)

        // Present the controller
        self.present(alertController, animated: true, completion: nil)
    }

    
    func buttonShadow(button : UIButton){
           button.layer.cornerRadius = 6
           button.layer.shadowColor = UIColor.black.cgColor
           button.layer.shadowOffset = CGSize(width: 2, height: 2);
           button.layer.shadowOpacity = 0.25
           button.layer.shadowRadius = 2
           button.layer.masksToBounds = false
       }
    
    func bottomRounderCorner(view: UIView) {
        view.clipsToBounds = true
        view.layer.cornerRadius = 14
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
    
    func addRightImageTo(textField : UITextField, image : UIImage) {
           let rightImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
           rightImageView.image = image
           textField.rightView = rightImageView
           textField.rightViewMode = .always
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


struct AppUtility {

    static func lockOrientation(_ orientation: UIInterfaceOrientationMask) {

        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            delegate.orientationLock = orientation
        }
    }

    /// OPTIONAL Added method to adjust lock and rotate to the desired orientation
    static func lockOrientation(_ orientation: UIInterfaceOrientationMask, andRotateTo rotateOrientation:UIInterfaceOrientation) {

        self.lockOrientation(orientation)

        UIDevice.current.setValue(rotateOrientation.rawValue, forKey: "orientation")
        UINavigationController.attemptRotationToDeviceOrientation()
    }

}
