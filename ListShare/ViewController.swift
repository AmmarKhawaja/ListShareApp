//LISTS LIST
import UIKit
import Foundation
import FirebaseDatabase
 
var ref : DatabaseReference?
var refhandle : DatabaseHandle?
var listKeys = ["exampletest"]
var storedLists : [String]?
class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var listTableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataanddel()
        listTableView.layer.cornerRadius = 20
        ref = Database.database().reference()
        username = defaults.string(forKey: "user")
        
        
        ref?.child("Users").child(username!).child("addedList").observe(.childAdded, with: { (snapshot) in
            listKeys.append(snapshot.key)
            defaults.set(listKeys, forKey: "listKeys")
            print("A \(listKeys[0])")
            print("B \(listKeys[1])?")
            listKeys = defaults.object(forKey: "listKeys") as! [String]
            print("C \(listKeys[0])")
            print("D \(listKeys[1])")
        })
    }
    override func viewDidAppear(_ animated: Bool) {
        
        if (defaults.bool(forKey: "used")) {
            print("Not a New User!")
            
            refhandle = ref?.child("Users").child(defaults.string(forKey: "user")!).child("addedLists").observe(.childAdded, with: { (listsem) in
                print(listsem.key)
            })
        }
        else {
            print("Is a New User")
            self.performSegue(withIdentifier: "cont", sender: self)
            defaults.set(true, forKey: "used")
        }
        
        
    }
    
    func dataanddel() {
        listTableView.dataSource = self
        listTableView.delegate = self
    }
    
    func updateData() {
        _ = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(ViewController.refresh), userInfo: nil, repeats: true)
        
    }
    
    @objc func refresh() {
        listTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listcell", for: indexPath)
        cell.textLabel?.text = "New List"
        cell.textLabel?.font = UIFont(name: "MuktaMahee-Bold", size:20)
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.text = storedLists?[indexPath.row]
        cell.layer.cornerRadius = 20
        
        cell.layer.masksToBounds = true
        return cell
        
    }
}
 
