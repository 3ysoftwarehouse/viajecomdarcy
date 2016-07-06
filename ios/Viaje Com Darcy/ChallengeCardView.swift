import UIKit

class ChallengeCardView: UIView {

    override func awakeFromNib() {
        self.layer.cornerRadius = 15
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor(red: 102.0/255.0, green: 115.0/255.0, blue: 128.0/255.0, alpha: 1.0).CGColor
        self.clipsToBounds = true
    }
    
}
