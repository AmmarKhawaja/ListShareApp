//NEW LIST VIEW
import UIKit
//import FirebaseDatabase
//var ref3 : DatabaseReference?
//var ref3handle : DatabaseHandle?
class ViewController3: UIViewController {
    
    @IBOutlet weak var newListInput: UITextField!
    @IBOutlet weak var listnamePreview: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delanddata()
        //ref3 = Database.database().reference()
    }
    
    func delanddata() {
        newListInput.delegate = self
    }
 
}
extension ViewController3 : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        listnamePreview.text = newListInput.text!
        listnameIn = newListInput.text!
        //firebaseAddList(name: listnameIn!)
        return true
    }
    
    //func firebaseAddList(name: String) {
        //ref3?.child("Lists").childByAutoId().child("Name").setValue(name)
        //ref3handle = ref3?.child("Lists").observe(.childAdded, with: { (listsem) in
            //print(listsem.key)
            //ref3?.child("Users").child(username!).child("addedList").child(listsem.key).setValue("true")
            //ref3?.child("Lists").child(listsem.key).child("addedItems").child("example item").child("isDone").setValue(false)
            //ref3?.child("Lists").child(listsem.key).child("addedItems").child("example item").child("byUser").setValue(defaults.string(forKey: "user"))
        //})
        
    //}
    
}

