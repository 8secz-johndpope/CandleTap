/*🔥CandleTap_DateRefresh💧*/import UIKit

extension CollectionVC {
    
    func periodicDateRefresh(completion: () -> ()) {                        //print("·", terminator: "")
        
        /*if Calendar.current.component(.second, from: Date()) == 0 {       //print("minute ticked over")
         print("Date: \(Date())")
         apiServ.getFeeds(toPlot: exchangeID)
         }
         else {
         apiServ.getFeeds(toPlot: exchangeID)
         }*/
        
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            apiServ.getFeeds(toPlot: exchangeID)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            /// must be on main queue: periodic callback inside the completion handler, is called on a background thread
            topVC.reloadCV()
        }
        
        completion()
    }
    
    func kickoffTimer() {
        DispatchQueue.global(qos: .userInteractive).asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.periodicDateRefresh(){self?.kickoffTimer()}
        }
    }
}

