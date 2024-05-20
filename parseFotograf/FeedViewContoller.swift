//
//  FeedViewContoller.swift
//  parseFotograf
//
//  Created by Feyzullah Durası on 18.05.2024.
//

import UIKit
import Parse

class FeedViewContoller: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var postDizisi = [Post]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postDizisi.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedTableViewCell
        
        cell.kullaniciAdiLabel.text = postDizisi[indexPath.row].kullaniciAdi
        cell.kullaniciYorumLabel.text = postDizisi[indexPath.row].kullaniciYorumu
        postDizisi[indexPath.row].kullaniciGoesel.getDataInBackground { data, error in
            if error == nil {
                cell.postImageView.image = UIImage(data: data!)
            }
        }
        
        return cell
    }
    

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        verileriAl()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(verileriAl), name: Notification.Name("yeniPost"), object: nil)
    }
    
    @objc func verileriAl() {
        let query = PFQuery(className: "Post")
        query.addDescendingOrder("createdAt")
        
        query.findObjectsInBackground { objects, error in
            if error != nil {
                self.hataMesaji(title: "Hata", message: error?.localizedDescription ?? "hata")
                
            } else {
                if objects != nil {
                    if objects!.count > 0 {
                        self.postDizisi.removeAll(keepingCapacity: false)
                        
                        for object in objects! {
                            if let kullaniciIsmi = object.object(forKey: "postsahibi") as? String {
                                if let kullaniciYorum = object.object(forKey: "postyorum") as? String {
                                    if let kullaniciGorsel = object.object(forKey: "postgorsel") as? PFFileObject {
                                        let post = Post(kullaniciAdi: kullaniciIsmi, kullaniciYorumu: kullaniciYorum, kullaniciGoesel: kullaniciGorsel)
                                        self.postDizisi.append(post)
                                    }
                                }
                            }
                        }
                        self.tableView.reloadData()
                    }
                }
            }
        }
        
    }
    
    func hataMesaji(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: title, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true)
        
    }
    

}
