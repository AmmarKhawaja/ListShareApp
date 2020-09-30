//NEW LIST VIEW
import UIKit
import FirebaseDatabase
var ref3 : DatabaseReference?
var ref3handle : DatabaseHandle?

var tlistKey : String?
var did : Bool?
class ViewController3: UIViewController {
    var listKey : String? = " "
    @IBOutlet weak var newListInput: UITextField!
    @IBOutlet weak var listnamePreview: UILabel!
    @IBOutlet weak var addUsernameInput: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delanddata()
        ref3 = Database.database().reference()
        did = true
        //maybe remove later, observes all lists and puts them into main phone
        firebaseAddList(name: " ", user: " ") {na in
            print(" ")
        }
    }
    
    func delanddata() {
        newListInput.delegate = self
        addUsernameInput.delegate = self
    }
 
}
var listKey : String?
extension ViewController3 : UITextFieldDelegate {
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        if (did!) {
            
            listnamePreview.text = newListInput.text!
            listnameIn = newListInput.text!
            print(defaults.string(forKey: "user")!)
            firebaseAddList(name: newListInput.text!, user: defaults.string(forKey: "user")!) {listKey0 in
                self.listKey = listKey0
                print("completion listKey \(self.listKey!)")
            }
            newListInput.alpha = 0
        }
        if (addUsernameInput.text != "") {
            print("ADDED \(addUsernameInput.text!)")
            firebaseAddUserToList(user: addUsernameInput.text!, list: listKey!)
            
        }
        did = false
        return true
    }
    
    func firebaseAddList(name: String, user: String, completion: @escaping (String) -> Void) {
        
        listKey = ref3?.child("Users").child(user).child("addedLists").childByAutoId().key
            
        ref3?.child("Users").child(user).childByAutoId().child("Name").setValue(name)
        ref3?.child("Lists").child(listKey!).setValue("true")
        ref3?.child("Lists").child(listKey!).child("addedItems").child("example item").child("isDone").setValue("Not Done")
        ref3?.child("Lists").child(listKey!).child("addedItems").child("example item").child("byUser").setValue(defaults.string(forKey: "user"))
        
        print("listKey \(listKey!)")
    }
    
    func firebaseAddUserToList(user : String, list : String) {
        
        ref3?.child("Users").child(user).child("addedList").child(list).setValue(true)
        
    }
        
}

