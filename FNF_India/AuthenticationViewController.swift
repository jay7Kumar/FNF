//
//  AuthenticationViewController.swift
//  FNF_India
//
//  Created by mercurius solutions pvt ltd on 03/03/20.
//  Copyright © 2020 mercurius solutions pvt ltd. All rights reserved.
//

import UIKit
import AVFoundation

class AuthenticationViewController: BaseViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
   
    
    
    @IBOutlet weak var signatureImage: UIImageView!
    
    @IBOutlet weak var cameraImage: UIImageView!
    @IBOutlet weak var imageLabel: UILabel!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var signatureButton: UIButton!
    @IBOutlet weak var signatureLabel: UILabel!
    
    @IBOutlet weak var authenticationNavbar: UIView!
    @IBOutlet weak var continueButton: UIButton!
    let preferences = UserDefaults.standard
     let imagePicker = UIImagePickerController()
     var image: UIImage!
    var signatureFlag = false
    var cameraFlag = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AppUtility.lockOrientation(.portrait)
        buttonShadow(button: continueButton)
        bottomRounderCorner(view: authenticationNavbar)
        imagePicker.delegate = self
        continueButton.isEnabled = false
        continueButton.backgroundColor = UIColor(red: 0/255, green: 50/255, blue: 99/255, alpha: 0.5)
        self.navigationItem.title = "Authentication"
         NotificationCenter.default.addObserver(self, selector: #selector(self.showSignature(_:)), name: NSNotification.Name(rawValue: "notificationName"), object: nil)
        
       

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
         AppUtility.lockOrientation(.portrait)
        if (signatureFlag == true) && (cameraFlag == true) {
            continueButton.isEnabled = true
            continueButton.backgroundColor = UIColor(red: 0/255, green: 50/255, blue: 99/255, alpha: 1)
        }
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        AppUtility.lockOrientation(.all)
    }
    
    @objc func showSignature(_ notification: NSNotification) {

     if let signature = notification.userInfo?["image"] as? UIImage {
        signatureButton.isHidden = true
        signatureLabel.isHidden = true
        signatureImage.isHidden = false
        signatureImage.image = signature
        signatureFlag = true
     }
    }
    @IBAction func cameraButtonAction(_ sender: Any) {
        checkCameraAccess()
    }
    
    
    func checkCameraAccess() {
           switch AVCaptureDevice.authorizationStatus(for: .video) {
           case .denied:
               print("Denied, request permission from settings")
               presentCameraSettings()
           case .restricted:
               print("Restricted, device owner must approve")
           case .authorized:
               imagePicker.allowsEditing = true
               imagePicker.sourceType = .camera

               self.present(imagePicker, animated: true, completion: nil)
           case .notDetermined:
               AVCaptureDevice.requestAccess(for: .video) { success in
                   if success {
                       print("Permission granted, proceed")
                   } else {
                       print("Permission denied")
                   }
               }
           @unknown default:
               print("Unknown status")
           }
       }
    
    func presentCameraSettings() {
           let alertController = UIAlertController(title: "Error",
                                         message: "Camera access is denied",
                                         preferredStyle: .alert)
           alertController.addAction(UIAlertAction(title: "Cancel", style: .default))
           alertController.addAction(UIAlertAction(title: "Settings", style: .cancel) { _ in
               if let url = URL(string: UIApplication.openSettingsURLString) {
                   UIApplication.shared.open(url, options: [:], completionHandler: { _ in
                       // Handle
                   })
               }
           })

           present(alertController, animated: true)
       }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
           if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
//            print(pickedImage,"####")
            image = pickedImage

            cameraButton.isHidden = true
            imageLabel.isHidden = true
            cameraImage.isHidden = false
            cameraImage.image = pickedImage
            cameraFlag = true
               //image = UIImage(data: imageData)

//               profileImage.image = image
        }
         dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
           dismiss(animated: true, completion: nil)
       }
    
//    func postData(){
//        var params : NSMutableDictionary?
//        let request = NSMutableURLRequest(url: NSURL(string: "http://192.168.25.5/fnf/photoSave.php")! as URL)
//        let session = URLSession.shared
//        request.httpMethod = "POST"
//
//
//        let imageData = image.jpegData(compressionQuality: 0.9)
//        let photobase64 = convertImageToBase64(cameraImage.image!)
//        let photo = percentEscapeString(string: photobase64)
//        let signaturebase64 = convertImageToBase64(signatureImage.image!)
//        let signature = percentEscapeString(string: signaturebase64)
////        var base64String = percentEscapeString(string: imageData!.base64EncodedStringWithOptions(NSData.Base64EncodingOptions(rawValue: 0))) // encode the image
//
//        params!["photo"] = [ "content_type": "image/jpeg", "filename":"test.jpg", "file_data": photo]
//        params!["signature"] = ["content_type": "image/jpeg", "filename":"test.jpg", "file_data": signature]
//            do{
//                request.httpBody = try JSONSerialization.data(withJSONObject: params, options: JSONSerialization.WritingOptions(rawValue: 0))
//            }catch{
//                print(error)
//            }
//
//            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//            request.addValue("application/json", forHTTPHeaderField: "Accept")
//
//        let task = URLSession.shared.dataTask(with: request as URLRequest) {
//                   data, response, error in
//
//                   if error != nil {
//                       print("error=\(String(describing: error))")
//                       return
//                   }
//                   guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
//                       print("Server error!")
//                       return
//                   }
//                   do {
//                          let json = try JSONSerialization.jsonObject(with: data!, options: [])
//
//                          print (json)
//
//                          guard let jsonArray = json as? [String: Any] else {
//                                return
//                          }
//
//                          if jsonArray["message"] as! String != "success" {
//                              return
//                          }
//                   }
//                   catch {
//                       print("JSON error: \(error.localizedDescription)")
//                   }
//               }
//               task.resume()
//        }
//
    func uploadImages(){
       
        guard let emailId = preferences.string(forKey: "email") else {
                   return
               }
        guard let signature = signatureImage.image else {
                   return
               }
        guard let photo = cameraImage.image else {
            return
        }
        guard let url = URL(string: "http://192.168.25.5/fnf/photoSave.php") else {
            return
        }
        var request = URLRequest(url: url)
        print(url,"@@@@")
                            request.httpMethod = "POST"
        let signatureData = convertImageToBase64(signature)
        let photoData = convertImageToBase64(photo)
        let signatureDataPercent = signatureData.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let photoDataPercent = photoData.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
    
//        print(signatureDataPercent,"$$$")
        print(photoDataPercent,"###")
//        let signatureConverted = percentEscapeString(string: signatureData)
//        let photoConverted = percentEscapeString(string: photoData)
        
        let postString = "email_id=\(String(describing: emailId))&photo=\(photoDataPercent)&signature=\(signatureDataPercent)"
        
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
                       return
                   }
            }
            catch {
                print("JSON error: \(error.localizedDescription)")
            }
        }
        task.resume()
                
    }
    
    func uploadData(){
        let session = URLSession.shared
        let url = URL(string: "http://192.168.25.5/fnf/photo_save.php")
        
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        guard let emailId = preferences.string(forKey: "email") else {
            return
        }
        guard let signature = signatureImage.image else {
            return
        }
//        print(signature,"$$")
//        guard let photo = cameraImage.image else {
//            return
//        }
//        print(photo,"####")
        
        var params: [String:String] = [:]
        params["email_id"] = emailId
        print(emailId,"$$$$")
        
        let boundary = generateBoundaryString()
        let signatureData = signature.jpegData(compressionQuality: 1)
        let strBase64 = signatureData!.base64EncodedString(options: .lineLength64Characters)
        print(strBase64,"$$$$$")
        

        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        if signatureData == nil {
            return;
        }
        
        request.httpBody = createBodyWithParameters(parameters: params, filePathKey: "signature", imageDataKey: signatureData! as NSData, boundary: boundary) as Data

        let task = session.dataTask(with: request) { data, response, error in

            if error != nil || data == nil {
                print("Client error!")
                return
            }

            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("Server error!")
                return
            }

            /*guard let mime = response.mimeType, mime == "application/json" else {
                print("Wrong MIME type!")
                return
            }*/

            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: [])
                
                print (json)
                
                guard let jsonArray = json as? [String: Any] else {
                      return
                }
                
                if jsonArray["message"] as! String != "success" {
                    return
                }
            } catch {
                print("JSON error: \(error.localizedDescription)")
            }
        }

            task.resume()
        }
        


        

    @IBAction func continueButtonAction(_ sender: Any) {
//        uploadImages()
//        let signature = convertImageToBase64(signatureImage.image!)
////        let photo = convertImageToBase64(cameraImage.image!)
//        print(signature,"$$$$")
       
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
       let personalDetailsVC = storyboard.instantiateViewController(withIdentifier: "personalDetailsVC") as! PersonalDetailsViewController
//
        self.navigationController?.pushViewController(personalDetailsVC, animated: true)
    }
    
    
//    func createBodyWithParameters(parameters: [String: String]?, boundary: String) -> Data {
//        var body = Data();
//
//           if parameters != nil {
//               for (key, value) in parameters! {
//                body.append(Data("--\(boundary)\r\n".utf8))
////                   body.appendString(string: "--\(boundary)\r\n")
//                body.append(Data("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".utf8))
////                   body.appendString(string: "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
//                 body.append(Data("\(value)\r\n".utf8))
////                   body.appendString(string: "\(value)\r\n")
//               }
//           }
//
//           let filename = "user-profile.jpg"
//
//           let mimetype = "image/jpg"
//           body.append(Data("--\(boundary)\r\n".utf8))
////           body.appendString(string: "--\(boundary)\r\n")
//           body.append(Data("Content-Disposition: form-data; name=\"fileType\"\r\n\r\n".utf8))
////           body.appendString(string: "Content-Disposition: form-data; name=\"fileType\"\r\n\r\n")
//          body.append(Data("jpeg\r\n".utf8))
////           body.appendString(string: "jpeg\r\n")
//           body.append(Data("--\(boundary)\r\n".utf8))
////           body.appendString(string: "--\(boundary)\r\n")
//         body.append(Data("Content-Disposition: form-data; name=\"file\"; filename=\"\(filename)\"\r\n".utf8))
////           body.appendString(string: "Content-Disposition: form-data; name=\"file\"; filename=\"\(filename)\"\r\n")
//          body.append(Data("Content-Type: \(mimetype)\r\n\r\n".utf8))
////           body.appendString(string: "Content-Type: \(mimetype)\r\n\r\n")
//
//           body.append(image.jpegData(compressionQuality: 0)!)
//         body.append(Data("\r\n".utf8))
////           body.appendString(string: "\r\n")
//         body.append(Data( "--\(boundary)--\r\n".utf8))
////           body.appendString(string: "--\(boundary)--\r\n")
//
//           return body
//       }
       
       func generateBoundaryString() -> String {
           return "Boundary-\(NSUUID().uuidString)"
       }
    
    
    func createBodyWithParameters(parameters: [String: String]?, filePathKey: String?, imageDataKey: NSData, boundary: String) -> NSData {
        let body = NSMutableData();

        if parameters != nil {
            for (key, value) in parameters! {
                body.appendString(string: "--\(boundary)\r\n")
                body.appendString(string: "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.appendString(string: "\(value)\r\n")
            }
        }

        let filename = "user-profile.jpg"

        let mimetype = "image/jpg"
        
        body.appendString(string: "--\(boundary)\r\n")
//        body.appendString(string: "Content-Disposition: form-data; name=\"fileType\"\r\n\r\n")
        body.appendString(string: "jpeg\r\n")
        
        body.appendString(string: "--\(boundary)\r\n")
        body.appendString(string: "Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(filename)\"\r\n")
        body.appendString(string: "Content-Type: \(mimetype)\r\n\r\n")
//        body.append(image.jpegData(compressionQuality: 0)!)
        body.append(imageDataKey as Data)
        body.appendString(string: "\r\n")

        body.appendString(string: "--\(boundary)--\r\n")

        return body
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    func convertImageToBase64(_ image: UIImage) -> String {
        
        
//        let imageData = image.pngData()!
         let imageData:NSData = image.jpegData(compressionQuality: 0.4)! as NSData
//        return imageData.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
        return imageData.base64EncodedString()
        
//        let imageData = image.pngData()! as NSData
       
//        let strBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
//           let strBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
//           return strBase64
    }
    
    func percentEscapeString(string: String) -> String {
        return CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                       string as CFString,
            nil,
            ":/?@!$&'()*+,;=" as CFString,
            CFStringBuiltInEncodings.UTF8.rawValue) as! String;
    }


}

extension NSMutableData {

    func appendString(string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
        append(data!)
    }
}

