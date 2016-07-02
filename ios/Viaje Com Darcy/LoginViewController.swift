import UIKit
import Parse

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let query = PFQuery(className: "Escola")
        query.findObjectsInBackgroundWithBlock { (result, error) in
            result?.forEach({ (escola) in
                print(escola)
            })
        }
    }
}
