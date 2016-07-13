import UIKit

class ChallengeViewController: UIViewController,
    UIPageViewControllerDataSource, UIPageViewControllerDelegate,
    UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var challengeService: ChallengeService!
    
    private var pageController: UIPageViewController?
    private var imagePicker: UIImagePickerController!
    private var challenges: [Challenge] = []
    
    private var selectedChallenge: Challenge?

    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
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
            self.setupPageView()
        }
    }
    
    func setupPageView() {
        pageController = UIPageViewController(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)
        
        pageController?.delegate = self
        pageController?.dataSource = self
        
        let startingViewController: CurrentChallengeViewController = viewControllerAtIndex(0)!
        
        let viewControllers: [UIViewController] = [startingViewController]
        pageController?.setViewControllers(viewControllers, direction: .Forward, animated: true, completion: nil)
        
        self.addChildViewController(pageController!)
        containerView.addSubview(self.pageController!.view)
        
        
        let pageViewRect = containerView.bounds
        pageController?.view.frame = pageViewRect
        pageController?.didMoveToParentViewController(self)
    }
    
    func viewControllerAtIndex(index: Int) -> CurrentChallengeViewController? {
        if challenges.count == 0 || index >= challenges.count {
            return nil
        }
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let dataViewController = storyboard.instantiateViewControllerWithIdentifier("CurrentChallengeViewController") as! CurrentChallengeViewController
        
        dataViewController.challenge = challenges[index]
        dataViewController.onChallengeAcceptedListener = onChallengeAcceptedListener
        return dataViewController
    }
    
    func indexOfViewController(viewController: CurrentChallengeViewController) -> Int {
        if let searchedChallenge: Challenge = viewController.challenge {
            return challenges.indexOf({ challenge in challenge.id == searchedChallenge.id })!
        } else {
            return NSNotFound
        }
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        var index = indexOfViewController(viewController as! CurrentChallengeViewController)
        if index == 0 || index == NSNotFound {
            return nil
        }
        index -= 1
        return viewControllerAtIndex(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        var index = indexOfViewController(viewController as! CurrentChallengeViewController)
        if index == NSNotFound {
            return nil
        }
        index += 1
        if index == challenges.count {
            return nil
        }
        return viewControllerAtIndex(index)
    }
    
    func setupImagePicker() {
        self.imagePicker = UIImagePickerController()
        imagePicker.delegate = self
    }
    
    func onChallengeAcceptedListener(challenge: Challenge) {
        selectedChallenge = challenge
        displayImageOptions()
    }
    
    func displayImageOptions() {
        let alertVC = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
        let cameraAction = UIAlertAction(title: "Tirar foto com a câmera", style: .Default) { (action) in
            self.openCamera()
        }
        let galleryAction = UIAlertAction(title: "Escolher foto nos álbuns", style: .Default) { (action) in
            self.openGallery()
        }
        let cancelAction = UIAlertAction(title: "Cancelar", style: .Destructive, handler: nil)
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
