//
//  ViewController.swift
//  parseFotograf
//
//  Created by Feyzullah Durası on 17.05.2024.
//

import UIKit
import Parse

class ViewController: UIViewController {

    @IBOutlet weak var ParolaText: UITextField!
    @IBOutlet weak var kullaniciAdiText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        /*
        let parseObject = PFObject(className: "Meyve")
        parseObject["isim"] = "Elma"
        parseObject["Kalori"] = 100
        
        parseObject.saveInBackground { success, error in
            if error != nil {
                print(error?.localizedDescription)
            } else {
                print("upload bitti")
            }
        }*/
        let query = PFQuery(className: "Meyve")
        
        //query.whereKey("isim", equalTo: "Elma")
        query.whereKey("kalori", greaterThan: 120)
        
        query.findObjectsInBackground { objects, error in
            if error != nil {
                print(error?.localizedDescription)
            } else {
                print(objects)
            }
        }
    }
    @IBAction func girisYapTiklandi(_ sender: Any) {
        
        if kullaniciAdiText.text != "" && ParolaText.text != "" {
            PFUser.logInWithUsername(inBackground: kullaniciAdiText.text!, password: ParolaText.text!) { user, error in
                if error != nil {
                    self.hataMesajiGoster(title: "hata", message: error?.localizedDescription ?? "hata")
                    
                } else {
                    self.performSegue(withIdentifier: "toTabBar", sender: nil)
                }
            }
        }
        
        
    }
    
    @IBAction func kayitOlTiklandi(_ sender: Any) {
        
        if kullaniciAdiText.text != "" && ParolaText.text != "" {
            
            let user = PFUser()
            user.username = kullaniciAdiText.text!
            user.password = ParolaText.text!
            
            user.signUpInBackground { seccess, error in
                if error != nil {
                    self.hataMesajiGoster(title: "hata", message: error?.localizedDescription ?? "hata")
                } else {
                    self.hataMesajiGoster(title: "haat", message: "kullanıcı adı ve parola gir.")
                }
            }
            
        } else {
            hataMesajiGoster(title: "Hata! ", message: "kullanıcı Adı Ve Parola Girmelisin,z")
        }

    }
    
    func hataMesajiGoster(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
    
}
    



