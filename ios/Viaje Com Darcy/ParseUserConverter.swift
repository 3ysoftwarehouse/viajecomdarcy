import Foundation
import Parse

class ParseUserConverter {
    
    func convert(parseUser: PFUser!) -> User {
        let name = parseUser.valueForKey("name") as? String
        return User(id: parseUser.objectId, name: name)
    }
    
}