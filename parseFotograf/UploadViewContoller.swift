//
//  UploadViewContoller.swift
//  parseFotograf
//
//  Created by Feyzullah Durası on 18.05.2024.
//

import UIKit
import Parse

class UploadViewContoller: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var paylasButton: UIButton!
    @IBOutlet weak var yorumTextField: UITextField!
    @IBOutlet weak var imageTextField: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let keyboardRecognizer = UITapGestureRecognizer(target: self, action: #selector(klavyeSakla))
        
        view.addGestureRecognizer(keyboardRecognizer)
        
        imageTextField.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(gorselSec))
        imageTextField.addGestureRecognizer(gestureRecognizer)
        
        paylasButton.isEnabled = false
        
    }
    
    @objc func klavyeSakla() {
        view.endEditing(true)
    }
    
    @objc func gorselSec() {
        
        let pickerContoller = UIImagePickerController()
        pickerContoller.delegate = self
        pickerContoller.sourceType = .photoLibrary
        present(pickerContoller, animated: true)
        
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageTextField.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true)
        paylasButton.isEnabled = true
    }
    
    @IBAction func paylasButtonClicked(_ sender: Any) {
        
        paylasButton.isEnabled = false
        let post = PFObject(className: "Post")
        
        let data = imageTextField.image?.jpegData(compressionQuality: 0.5)
        if let data = data {
            if PFUser.current() != nil {
                let parseImage = PFFileObject(name: "image.jpg", data: data)
                
                post["postgorsel"] = parseImage
                post["postYorum"] = yorumTextField.text!
                post["postsahibi"] = PFUser.current()!.username!
                
                post.saveInBackground { success, error in
                    if error != nil {
                        let alert = UIAlertController(title: "hata", message: error?.localizedDescription ?? "hata", preferredStyle: .alert)
                        let okButton = UIAlertAction(title: "OK", style: .default)
                        alert.addAction(okButton)
                        self.present(alert, animated: true, completion: nil)
                    } else {
                        self.yorumTextField.text = ""
                        self.imageTextField.image = UIImage(named: "gorselsec")
                        self.tabBarController?.selectedIndex = 0
                        
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "yeniPost"), object: nil)
                        
                    }
                }
            }
        }
        
        
    }
    
}
