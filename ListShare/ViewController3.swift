//NEW LIST VIEW
import UIKit
import FirebaseDatabase
var ref3 : DatabaseReference?
var ref3handle : DatabaseHandle?
var listKey : String?
var tlistKey : String?
var did : Bool?
class ViewController3: UIViewController {
    
    @IBOutlet weak var newListInput: UITextField!
    @IBOutlet weak var listnamePreview: UILabel!
    @IBOutlet weak var addUsernameInput: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delanddata()
        ref3 = Database.database().reference()
        did = true
        
    }
    
    func delanddata() {
        newListInput.delegate = self
        addUsernameInput.delegate = self
    }
 
}
extension ViewController3 : UITextFieldDelegate {
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        if (did!) {
            
            listnamePreview.text = newListInput.text!
            listnameIn = newListInput.text!
            tlistKey = firebaseAddList(name: newListInput.text!)
            newListInput.alpha = 0
        }
        if (addUsernameInput.text != "") {
            print("ADDED \(addUsernameInput.text!)")
            firebaseAddUserToList(user: addUsernameInput.text!, list: tlistKey!)
        }
        did = false
        return true
    }
    
    func firebaseAddList(name: String) -> String{
        ref3?.child("Lists").childByAutoId().child("Name").setValue(name)
        ref3handle = ref3?.child("Lists").observe(.childAdded, with: { (listsem) in
            print(listsem.key)
            ref3?.child("Users").child(username!).child("addedList").child(listsem.key).setValue("true")
            ref3?.child("Lists").child(listsem.key).child("addedItems").child("example item").child("isDone").setValue(false)
            ref3?.child("Lists").child(listsem.key).child("addedItems").child("example item").child("byUser").setValue(defaults.string(forKey: "user"))
            
            listKey = listsem.key
            print("listKey \(listKey!)")
            
        })
        
        return listKey ?? " "
    }
    func firebaseAddUserToList(user : String, list : String) {
        
        ref3?.child("Users").child(user).child("addedList").child(tlistKey!).setValue(true)
        print("listKey check2 \(tlistKey!)")
            
        
        
    }
        
}

