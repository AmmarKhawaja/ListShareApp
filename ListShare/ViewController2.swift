//SPECIFIC LIST VIEW
import UIKit
import FirebaseDatabase
 
var ref2 : DatabaseReference?
var ref2handle : DatabaseHandle?

var listnameIn : String?
var itemlistIn : String?
var sublistCopyIn : String?
var doneswitchIn : Int?
 
var listname : Array<String>?
var itemlist : Array<String>?
var sublistCopy : Array<String>?
var doneswitch : Array<Int>?
var s = 0

var transfergetList = " "

class ViewController2: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var newItemInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delanddata()
        ref2 = Database.database().reference()
        self.newItemInput.delegate = self
        updateData2()
    }
    
    func delanddata() {
        itemTableView.dataSource = self
        itemTableView.delegate = self
        newItemInput.delegate = self
    }
 
    @IBOutlet weak var itemTableView: UITableView!
    
    func updateData2() {
        _ = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(ViewController2.refresh2), userInfo: nil, repeats: true)
        
    }

    @objc func refresh2() {
        itemTableView.reloadData()
    }}


extension ViewController2 : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        itemlistIn = newItemInput.text!
        print(newItemInput.text!)
        ref2?.child("Lists").child(getlistKey).child("addedItems").child(newItemInput.text!).setValue(true)
        return true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        itemTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemcell", for: indexPath)
        
        cell.textLabel?.text = getList[indexPath.row]
        transfergetList = getList[indexPath.row]
        
        cell.textLabel?.font = UIFont(name: "MuktaMahee-Bold", size:20)
        cell.textLabel?.textColor = UIColor.white
 
        cell.detailTextLabel?.font = UIFont(name: "MuktaMahee-Bold", size:14)
        cell.detailTextLabel?.textColor = UIColor.white
        cell.detailTextLabel?.alpha = 0.5
        cell.layer.cornerRadius = 30
        
        return cell
    }
    
}
