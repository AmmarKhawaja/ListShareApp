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

var getlistKey = "exampleID"

var getList = ["exItem"]
class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var listTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataanddel()
        listTableView.layer.cornerRadius = 20
        ref = Database.database().reference()
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        updateData()
        
        listTableView.delegate = self
        listTableView.dataSource = self
        
        if (defaults.bool(forKey: "used")) {
            print("Not a New User!")
            
            refhandle = ref?.child("Users").child(defaults.string(forKey: "user")!).child("addedLists").observe(.childAdded, with: { (listsem) in
                print("overwatch \(listsem.key)")
            })
            
            username = defaults.string(forKey: "user")
                
            //Gets your list keys
            ref?.child("Users").child(username!).child("addedList").observe(.childAdded, with: { (snapshot) in
                
                listKeys.removeAll()
                listKeys.append(snapshot.key)
                
            })
                
            
            ref?.child("Lists").observe(.childAdded, with: { (snapshot) in
            
                for key in listKeys {
                    if(key == snapshot.key) {
                        print("found \(snapshot.key) and \(key)")
                    }
                }
            
            })
            
            
        }
        else {
            
            print("Is a New User")
            self.performSegue(withIdentifier: "cont", sender: self)
            defaults.set(true, forKey: "used")
            defaults.set(listKeys, forKey: "listKeys")
            defaults.set(allListID, forKey: "allListID")
        
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
        
        cell.textLabel?.font = UIFont(name: "MuktaMahee-Bold", size:20)
        cell.textLabel?.textColor = UIColor.white
        
        cell.layer.cornerRadius = 20
        
        cell.layer.masksToBounds = true
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        getlistKey = listKeys[indexPath.row]
        
        ref?.child("Lists").child(getlistKey).child("addedItems").observe(.childAdded, with: { (snapshot) in
            print(getlistKey)
            getList.append(snapshot.key)
            print(getList[1])
        })
        self.performSegue(withIdentifier: "showlist", sender: self)
    }
}
 
