//SPECIFIC LIST VIEW
import UIKit
//import FirebaseDatabase
 
//var ref2 : DatabaseReference?
//var ref2handle : DatabaseHandle?
 
var listnameIn : String?
var itemlistIn : String?
var sublistCopyIn : String?
var doneswitchIn : Int?
 
var listname : Array<String>?
var itemlist : Array<String>?
var sublistCopy : Array<String>?
var doneswitch : Array<Int>?
var s = 0
 
class ViewController2: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var newItemInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delanddata()
        //ref2 = Database.database().reference()
    }
    
    func delanddata() {
        itemTableView.dataSource = self
        itemTableView.delegate = self
        newItemInput.delegate = self
    }
 
    @IBOutlet weak var itemTableView: UITableView!
    
}
 
extension ViewController2 : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        itemlistIn = newItemInput.text!
        print(newItemInput.text!)
        
        return true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if (doneswitch?[indexPath.row] == 0) {
            //sublist?[indexPath.row].append(" DONE")
            doneswitch?[indexPath.row] = 1
        }
        else {
            //let sub = sublistCopy![indexPath.row]
            //sublist?[indexPath.row] = sub
            doneswitch?[indexPath.row] = 0
        }
        itemTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemcell", for: indexPath)
        //cell.textLabel?.text = list?[indexPath.row]
        cell.textLabel?.font = UIFont(name: "MuktaMahee-Bold", size:20)
        cell.textLabel?.textColor = UIColor.white
 
        cell.detailTextLabel?.font = UIFont(name: "MuktaMahee-Bold", size:14)
        cell.detailTextLabel?.textColor = UIColor.white
        cell.detailTextLabel?.alpha = 0.5
        cell.layer.cornerRadius = 30
        //if (indexPath.row < sublist!.count) {
        //    cell.detailTextLabel?.text = sublist![indexPath.row]
        //}
        //else {
        //    sublist?.append(" ")
        //    sublistCopy?.append(" ")
        //}
        return cell
    }
    
}

