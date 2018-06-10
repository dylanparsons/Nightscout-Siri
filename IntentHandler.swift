import Foundation
import Intents
import UIKit

class IntentHandler: INExtension, INVisualCodeDomainHandling, INGetVisualCodeIntentHandling {
    
    override func handler(for intent: INIntent) -> Any {
        // This is the default implementation.  If you want different objects to handle different intents,
        // you can override this and return the handler you want for that particular intent.
//        print("handler")
        
        return self
    }
    
    func resolveVisualCodeType(for intent: INGetVisualCodeIntent, with completion: @escaping (INVisualCodeTypeResolutionResult) -> Void) {
//        print("resolveVisualCodeType")
//        switch intent.visualCodeType {
//        case .contact, .unknown:
//            completion(INVisualCodeTypeResolutionResult.success(with: .contact))
//        default:
//            completion(INVisualCodeTypeResolutionResult.unsupported())
//        }
        completion(INVisualCodeTypeResolutionResult.success(with: .contact))
    }
    
    func confirm(intent: INGetVisualCodeIntent, completion: @escaping (INGetVisualCodeIntentResponse) -> Void) {
//        print("confirm")
        // check if user is authorized
        completion(INGetVisualCodeIntentResponse(code: .ready, userActivity: nil))
//        let userActivity = NSUserActivity(activityType: String(describing: INGetVisualCodeIntent.self))
//        userActivity.userInfo = ["error": "InactiveAccount"]
//        completion(INGetVisualCodeIntentResponse(code: .failureRequiringAppLaunch, userActivity: userActivity))
    }
    
    func handle(intent: INGetVisualCodeIntent, completion: @escaping (INGetVisualCodeIntentResponse) -> Void) {
//        print("handle")
        let siriResponse = INGetVisualCodeIntentResponse(code: .success, userActivity: nil)
        
        let endpoint = "https://YOURSITENAME.herokuapp.com/api/v1/entries.json"
        let url = URL(string: endpoint)
        
        URLSession.shared.dataTask(with: url!, completionHandler: {(data, response, error) -> Void in
            if error != nil {
                print(error)
                return
            }
            
            let str = String(data: data!, encoding: .utf8)
            let newdData = str!.data(using: .utf8)
            let JSON = try! JSONSerialization.jsonObject(with: newdData!) as? [[String: Any]]
            let first = JSON!.first
            let sgv = first!["sgv"] as! Int
            
            let mgdl = sgv
            let mmol = Float(mgdl/18)
            
            let imageData = UIImagePNGRepresentation(LetterImageGenerator.imageWith(name: "\(mgdl) mg/dl \n \(mmol) mmol/L")!)
            siriResponse.visualCodeImage = INImage(imageData: imageData!)
            
            completion(siriResponse)
        }).resume()
        
    }
    
    
}
