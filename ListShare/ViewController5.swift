//ITEM INFO SCREEN
import Foundation
import FirebaseDatabase
var ref4 : DatabaseReference?
class ViewController5: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(getlistKey)
        print(transfergetList)
        ref4?.child("Lists").child(getlistKey).child("addedItems").child(transfergetList).observeSingleEvent(of: .value, with: { (snapshot) in
            print("byUser")
            print(snapshot.value!)
        })
    }
}
