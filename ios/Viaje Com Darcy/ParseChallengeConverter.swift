import Foundation
import Parse

class ParseChallengeConverter {

    func convert(parseObject: PFObject!) -> Challenge? {
        if let title = parseObject["title"] as? String,
            let description = parseObject["description"] as? String {
            return Challenge(id: parseObject.objectId, title: title, description: description)
        }
        return nil
    }
    
}