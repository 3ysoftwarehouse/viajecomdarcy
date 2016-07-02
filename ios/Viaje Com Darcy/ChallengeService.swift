import Foundation

protocol ChallengeService {
    func findAll(block: [Challenge] -> Void)
    func saveForLoggedUser(image image: NSData, toChallenge challenge: Challenge!, block: Bool -> Void)
}