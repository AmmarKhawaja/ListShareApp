//LISTS LIST
import UIKit
import Foundation
import FirebaseDatabase
 
var ref : DatabaseReference?
var refhandle : DatabaseHandle?


var listNames = ["exampleName"]
var listKeys = ["exampleKey"]

var allListID = ["exampleID"]
var allListNames = ["exampleNameChild"]

var storedLists : [String]?
class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var listTableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataanddel()
        listTableView.layer.cornerRadius = 20
        ref = Database.database().reference()
        username = defaults.string(forKey: "user")
        
        //Gets your list keys
        ref?.child("Users").child(username!).child("addedList").observe(.childAdded, with: { (snapshot) in
            
            listKeys.append(snapshot.key)
            defaults.set(listKeys, forKey: "listKeys")
            
            listKeys = defaults.object(forKey: "listKeys") as! [String]
            
        })
        //Gets all list keys
        ref?.child("Lists").observe(.childAdded, with: { (snapshot) in
            allListID.append(snapshot.key)
            defaults.set(allListID, forKey: "allListID")
            allListID = defaults.object(forKey: "allListID") as! [String]
            
        })
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        updateData()
        
        listTableView.delegate = self
        listTableView.dataSource = self
        
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
        _ = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(ViewController.refresh), userInfo: nil, repeats: true)
        
    }
    
    @objc func refresh() {
        listTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listKeys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listcell", for: indexPath)
        cell.textLabel?.text = listKeys[indexPath.row]
        print(listKeys[indexPath.row])
        cell.textLabel?.font = UIFont(name: "MuktaMahee-Bold", size:20)
        cell.textLabel?.textColor = UIColor.white
        
        cell.layer.cornerRadius = 20
        
        cell.layer.masksToBounds = true
        return cell
        
    }
}
 
