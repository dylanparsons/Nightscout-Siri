import UIKit
import Intents

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        INPreferences.requestSiriAuthorization{ (status: INSiriAuthorizationStatus) in
            switch (status){
            case INSiriAuthorizationStatus.authorized:
                print("Siri is Authorized")
                break
            case INSiriAuthorizationStatus.denied:
                print("Siri is Denied")
                break
            default:
                print("Siri is set to default.")
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

