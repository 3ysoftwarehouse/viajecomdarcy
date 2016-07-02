import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var userService: UserService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        checkUserAuthenticated()
    }
    
    func checkUserAuthenticated() {
        if (userService.isAuthenticated()) {
            goToMain()
        }
    }
    
    @IBAction func attemptLogin(sender: AnyObject) {
        if (!validateFields()) {
            return
        }
        
        if let username = usernameTextField.text, let password = passwordTextField.text {
            userService.authenticate(username, password: password, block: { (result) in
                self.onLoginResult(result)
            })
        }
    }
    
    func validateFields() -> Bool {
        guard usernameTextField.text != nil && usernameTextField.text?.isEmpty == false else {
            usernameTextField.layer.borderColor = UIColor.redColor().CGColor
            displayError(message: "Por favor, preencha o RG.")
            return false
        }
        
        guard passwordTextField.text != nil && passwordTextField.text?.isEmpty == false else {
            passwordTextField.layer.borderColor = UIColor.redColor().CGColor
            displayError(message: "Por favor, preencha a senha.")
            return false
        }
        return true
    }
    
    func onLoginResult(result: User?) {
        guard result != nil else {
            displayError(message: "RG ou senha inválidos!")
            return
        }
        
        self.goToMain()
    }

    func goToMain() {
        self.performSegueWithIdentifier("ChallengeViewController", sender: nil)
    }
    
    func displayError(title title: String! = "Erro", message: String!, actionName: String! = "Fechar") {
        let alertController = UIAlertController(title: title, message:
            message, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: actionName, style: UIAlertActionStyle.Default,handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
}
