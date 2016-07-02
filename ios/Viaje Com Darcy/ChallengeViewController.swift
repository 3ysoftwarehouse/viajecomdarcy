import UIKit

class ChallengeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    var challengeService: ChallengeService!
    
    private var imagePicker: UIImagePickerController!
    private var challenges: [Challenge] = []
    
    private var selectedChallenge: Challenge?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadChallenges()
        setupImagePicker()
    }
    
    func loadChallenges() {
        activityIndicator.startAnimating()
        challengeService.findAll { (challenges) in
            self.challenges.appendContentsOf(challenges)
            self.activityIndicator.stopAnimating()
            self.tableView.reloadData()
        }
    }
    
    func setupImagePicker() {
        self.imagePicker = UIImagePickerController()
        imagePicker.delegate = self
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return challenges.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedChallenge = challenges[indexPath.row]
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        displayImageOptions()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier("ChallengeCell") as? ChallengeCell {
            let challenge = challenges[indexPath.row]
            cell.configureCell(challenge)
            return cell
        }
        
        return ChallengeCell()
    }
    
    func displayImageOptions() {
        let alertVC = UIAlertController(title: "Escolha uma imagem", message: nil, preferredStyle: .ActionSheet)
        let cameraAction = UIAlertAction(title: "Câmera", style: .Default) { (action) in
            self.openCamera()
        }
        let galleryAction = UIAlertAction(title: "Galeria", style: .Default) { (action) in
            self.openGallery()
        }
        let cancelAction = UIAlertAction(title: "Cancelar", style: .Default) { (action) in
            
        }
        alertVC.addAction(cameraAction)
        alertVC.addAction(galleryAction)
        alertVC.addAction(cancelAction)
        presentViewController(alertVC, animated: true, completion: nil)
    }
    
    func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            self.imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
            self.presentViewController(self.imagePicker, animated: true, completion: nil)
        } else {
            showAlert(withMessage: "Não foi possível accesar a camera.")
        }
    }
    
    func openGallery() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
            self.imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            self.presentViewController(self.imagePicker, animated: true, completion: nil)
        } else {
            showAlert(withMessage: "Não foi possível accesar a galeria de fotos.")
        }
    }
    
    func showAlert(withMessage message: String, andTitle title: String = "Erro") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        picker.dismissViewControllerAnimated(false, completion: nil)
        uploadImage(image)
    }
    
    func uploadImage(image: UIImage!) {
        let loadingController = displayLoading()
        
        let img = UIImageJPEGRepresentation(image, 0.8)
        challengeService.saveForLoggedUser(image: img!, toChallenge: selectedChallenge) { (saved) in
            loadingController.dismissViewControllerAnimated(false, completion: nil)
            if (saved) {
                self.showAlert(withMessage: "Imagem enviada com sucesso!", andTitle: "Sucesso")
            } else {
                self.showAlert(withMessage: "Não foi possível enviar a imagem. Tente novamente.")
            }
        }
    }
    
    func displayLoading() -> UIAlertController {
        let alert = UIAlertController(title: nil, message: "Enviando...", preferredStyle: .Alert)
        
        alert.view.tintColor = UIColor.blackColor()
        let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(10, 5, 50, 50)) as UIActivityIndicatorView
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        loadingIndicator.startAnimating();
        
        alert.view.addSubview(loadingIndicator)
        presentViewController(alert, animated: true, completion: nil)
        
        return alert
    }

}
