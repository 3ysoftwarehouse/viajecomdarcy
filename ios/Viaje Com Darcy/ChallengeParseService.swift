import Foundation
import Parse

class ChallengeParseService: ChallengeService {
    
    
    let POST_TYPE_CHALLENGE_ID = "BnlxOo7FtG"
    
    let parseChallengeConverter: ParseChallengeConverter!
    
    init(parseChallengeConverter: ParseChallengeConverter) {
        self.parseChallengeConverter = parseChallengeConverter
    }
    
    func findAll(block: [Challenge] -> Void) {
        let query = PFQuery(className: "Desafio")
        query.orderByAscending("title")
        query.findObjectsInBackgroundWithBlock { (results: [PFObject]?, error: NSError?) in
            
            var challenges: [Challenge] = []
            
            if let parseObjects = results {
                parseObjects.forEach({ (parseObject) in
                    if let challenge = self.parseChallengeConverter.convert(parseObject) {
                        challenges.append(challenge)
                    }
                })
            }
            block(challenges)
        }
    }
    
    func saveForLoggedUser(image image: NSData, toChallenge challenge: Challenge!, block: Bool -> Void) {
        let imageFile = PFFile(name: "image.jpg", data: image)
        imageFile?.saveInBackgroundWithBlock({ (saved, error) in
            if (saved) {
                
                let picture = PFObject(className: "Picture")
                picture["file"] = imageFile
                picture["thumbnail"] = imageFile
                picture.saveInBackgroundWithBlock({ (saved, error) in
                    if (saved) {
                        
                        let post = PFObject(className: "Post")
                        post["picture"] = picture
                        post["author"] = PFUser.currentUser()
                        post["type"] = PFObject(withoutDataWithClassName: "PostType", objectId: self.POST_TYPE_CHALLENGE_ID)
                        post.saveInBackgroundWithBlock({ (saved, error) in
                            block(saved)
                        })
                        
                    } else {
                        block(false)
                    }
                })
            } else {
                block(false)
            }
        })
    }
}