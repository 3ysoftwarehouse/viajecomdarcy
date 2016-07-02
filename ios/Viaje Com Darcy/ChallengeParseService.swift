import Foundation
import Parse

class ChallengeParseService: ChallengeService {
    
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
                let userChallengeImg = PFObject(className: "UserDesafioImagem")
                userChallengeImg["picture"] = imageFile
                userChallengeImg["desafio"] = PFObject(withoutDataWithClassName: "Desafio", objectId: challenge.id)
                userChallengeImg["user"] = PFUser.currentUser()
                userChallengeImg.saveInBackgroundWithBlock({ (saved, error) in
                    block(saved)
                })
            } else {
                block(false)
            }
        })
    }
}