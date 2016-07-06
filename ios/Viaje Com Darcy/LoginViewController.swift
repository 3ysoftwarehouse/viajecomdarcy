import UIKit
import Parse

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var userService: UserService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFields()
    }
    
    func setupFields() {
        usernameTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if (textField.isEqual(passwordTextField)) {
            self.view.endEditing(true)
            attemptLogin(textField)
        }
        return false
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
        
        let loadingController = displayLoading()
        if let username = usernameTextField.text, let password = passwordTextField.text {
            userService.authenticate(username, password: password, block: { (result) in
                self.onLoginResult(result, loadingController: loadingController)
            })
        } else {
            dismissLoading(loadingController)
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
    
    func displayLoading() -> UIAlertController {
        let alert = UIAlertController(title: nil, message: "Aguarde...", preferredStyle: .Alert)
        
        alert.view.tintColor = UIColor.blackColor()

        let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(10, 5, 50, 50)) as UIActivityIndicatorView
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        loadingIndicator.startAnimating();
        alert.view.addSubview(loadingIndicator)
        
        self.presentViewController(alert, animated: true, completion: nil)
        
        return alert
    }
    
    func dismissLoading(loadingController: UIAlertController, onCompleteBlock: (() -> Void)? = nil) {
        loadingController.dismissViewControllerAnimated(false) { 
            if (onCompleteBlock != nil) {
                onCompleteBlock!()
            }
        }
    }
    
    func onLoginResult(result: User?, loadingController: UIAlertController) {
        dismissLoading(loadingController) {
            guard result != nil else {
                self.displayError(message: "RG ou senha inválidos!")
                return
            }
            self.goToMain()
        }
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
