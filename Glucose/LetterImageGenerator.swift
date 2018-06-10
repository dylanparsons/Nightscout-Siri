import Foundation
import UIKit

class LetterImageGenerator: NSObject {
    class func imageWith(name: String?) -> UIImage? {
        let frame = CGRect(x: 0, y: 0, width: 600, height: 500)
        let nameLabel = UILabel(frame: frame)
        nameLabel.textAlignment = .center
        nameLabel.backgroundColor = UIColor(white: 1, alpha: 0)
        nameLabel.textColor = .black
        nameLabel.numberOfLines = 0
        nameLabel.font = UIFont.boldSystemFont(ofSize: 100)
        
        nameLabel.text = name
        UIGraphicsBeginImageContext(frame.size)
        if let currentContext = UIGraphicsGetCurrentContext() {
            nameLabel.layer.render(in: currentContext)
            let nameImage = UIGraphicsGetImageFromCurrentImageContext()
            return nameImage
        }
        return nil
    }
}
