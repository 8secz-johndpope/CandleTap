/*🔥CandleTap_SafeJsonObject💧*/import UIKit

class SafeJsonObject: NSObject {
    
    @objc override func setValue(_ value: Any?, forKey key: String) {
        
        let upperCasedFirstCharacter = String(key.first!).uppercased()
        let range = NSMakeRange(0, 1)
        let selectorString = NSString(string: key).replacingCharacters(in: range, with: upperCasedFirstCharacter)
        
        let selector = NSSelectorFromString("set\(selectorString):")
        let responds = self.responds(to: selector)
        
        if !responds {
            return
        }
        
        super.setValue(value, forKey: key)
    }
}

