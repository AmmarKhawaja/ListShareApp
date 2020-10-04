//ITEM INFO SCREEN
import UIKit
import Foundation
import FirebaseDatabase

var ref4 : DatabaseReference?
var isDone : String?
class ViewController5: UIViewController {
    
    @IBOutlet weak var createdbyText: UILabel!
    @IBOutlet weak var isdoneText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref4 = Database.database().reference()
        
        print(getlistKey)
        print(transfergetList)
        
        ref4?.child("Lists").child(getlistKey).child("addedItems").child(transfergetList).child("byUser").observe(.value, with: { (snapshot) in
            print("byUser")
            print(snapshot.value!)
            self.createdbyText.text = "Created By: \(snapshot.value!)"
        })
        ref4?.child("Lists").child(getlistKey).child("addedItems").child(transfergetList).child("isDone").observe(.value, with: { (snapshot) in
            print("isDone")
            print(snapshot.value!)
            self.isdoneText.text = "\(snapshot.value!)"
            isDone = (snapshot.value! as! String)
        })
        
        
        
    }
    
    @IBAction func isdoneButton(_ sender: Any) {
        if (isDone! == "Not Done") {
                ref4?.child("Lists").child(getlistKey).child("addedItems").child(transfergetList).child("isDone").setValue("Done")
                self.isdoneText.text = "Done"
            } else {
                ref4?.child("Lists").child(getlistKey).child("addedItems").child(transfergetList).child("isDone").setValue("Not Done")
                self.isdoneText.text = "Not Done"
            }
        
    }
    
    
}
