//LOGIN SCREEN//
import UIKit
import FirebaseDatabase
var ref0 : DatabaseReference?
var ref0handle : DatabaseHandle?
var username : String?
var defaults = UserDefaults.standard
class ViewController4: UIViewController {
 
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var instructText: UILabel!
    @IBOutlet weak var infoText: UILabel!
    @IBOutlet weak var usernameInput: UITextField!
    @IBOutlet weak var usernameTaken: UILabel!
    @IBOutlet weak var promptText: UILabel!
    @IBOutlet weak var exitButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delanddata()
        ref0 = Database.database().reference()
        initialViewSet()
        
    }
 
    func delanddata() {
        usernameInput.delegate = self
    }
    func initialViewSet() {
        usernameTaken.alpha = 0.1
        promptText.alpha = 0
        exitButton.isHidden = true
    }
 
}
extension ViewController4: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        username = usernameInput.text!
        
        ref0?.child("Users").observeSingleEvent(of: .value, with: { (snapshot) in
            if(snapshot.hasChild(username!)) {
                self.usernameDenied()
            }
            else {
                textField.resignFirstResponder()
                self.usernameAccepted()
            }
        })
        return true
    }
    
    func usernameAccepted() {
        ref0?.child("Users").child(username!).child("Premium").setValue("false")
        print("New User Created")
        self.usernameTaken.textColor = UIColor.green
        self.usernameTaken.text = "Username created!"
        self.usernameTaken.alpha = 1
 
        defaults.set(username, forKey: "user")
        
        let funct = ViewController3()
        funct.firebaseAddList(name: "Example List")
        
        print(defaults.string(forKey: "user")!)
        
        self.transitionToButton()
    }
    
    func usernameDenied() {
        print("User Already Exists")
        self.usernameTaken.alpha = 1
    }
    
    func transitionToButton() {
        UIView.animate(withDuration: 3.0, animations: {
            self.usernameTaken.alpha = 0
            self.titleText.alpha = 0.5
            self.instructText.alpha = 0
            self.infoText.alpha = 0
            self.usernameInput.alpha = 0
            self.exitButton.isHidden = false
        })
        
        UIView.animate(withDuration: 10.0, animations: {
            self.promptText.alpha = 0.7
        })
    }
}

