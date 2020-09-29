//ITEM INFO SCREEN
import UIKit
import Foundation
import FirebaseDatabase

var ref4 : DatabaseReference?

class ViewController5: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref4 = Database.database().reference()
        
        print(getlistKey)
        print(transfergetList)
        ref4?.child("Lists").child(getlistKey).child("addedItems").child(transfergetList).child("date").setValue("sep11")
        ref4?.child("Lists").child(getlistKey).child("addedItems").child(transfergetList).observe(.value, with: { (snapshot) in
            print("byUser")
            print(snapshot.value!)
        })
    }
}
