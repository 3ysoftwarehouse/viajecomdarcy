import UIKit

class RoundedButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = cornerRadius()
    }
    
    func cornerRadius() -> CGFloat {
        return self.frame.height / 2
    }
    
}
