//
//  UploadViewContoller.swift
//  parseFotograf
//
//  Created by Feyzullah Durası on 18.05.2024.
//

import UIKit

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
        
        
        
    }
    
}
