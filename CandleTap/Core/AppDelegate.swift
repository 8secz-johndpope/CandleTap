/*🔥CandleTap_AppDelegate💧*/import UIKit

@UIApplicationMain class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    lazy var orientationLock = UIInterfaceOrientationMask.all       /// set orientations you want allowed by default
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return orientationLock
    }
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        frameHeight = Double(globalWindow.frame.height)
        frameWidth = Double(globalWindow.frame.width)
        
        setColoursFromSettings()
        apiServ.getFeeds(toPlot: exchangeID)   // only needs to be called at this stage, before selecting a chart to plot, for *current* prices
        
        modelName = UIDevice.modelName
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = cellDefaultColour
        window?.makeKeyAndVisible()
        globalWindow = window!
        
        AppUtility.lockOrientation(.landscape)
        
        backgroundVC = UIViewController()
        backgroundVC.view.backgroundColor = cellDefaultColour       /// must match window's background colour to be invisible when rotating landscape->portrait
        backgroundVC.view.frame = globalWindow.frame
        
        getOrientationAtLaunch()                                    ; print("launching on \(modelName) in \(launchOrientation) orientation")
        
        if statusBarUIView!.responds(to:#selector(setter: UIView.backgroundColor)) {
            statusBarUIView!.backgroundColor = .clear
        }
        
        UINavigationBar.appearance().barTintColor = defaultColour
        UINavigationBar.appearance().shadowImage = UIImage()
        
        //print(formattedDateString(Date(), roundedDown: false, prefix: "                      on", suffix: "", short: false))
        return true
    }
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        navController = UINavigationController(rootViewController: backgroundVC) /// temporary, unseen initial root view controller
        window?.rootViewController = navController                  //; print("VCs*: \(String(describing: nav Controller?.viewControllers))")
        
        pairListVC.setupAndPresent(vc: pairListVC)
        //        pairListVC.gotoView(vc: pairListVC)
        pairListVC.setTopViewController()
        return true
    }
    
    var statusBarUIView: UIView? {
        if #available(iOS 13.0, *) {
            let tag = 38482458385
            if let statusBar = globalWindow.viewWithTag(tag) {
                return statusBar
            } else {
                ///let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)   // deprecated
                let statusBarView = UIView(frame: (globalWindow.windowScene?.statusBarManager!.statusBarFrame)!)
                statusBarView.tag = tag
                globalWindow.addSubview(statusBarView)
                return statusBarView
            }
        } else if responds(to: Selector(("statusBar"))) {
            return value(forKey: "statusBar") as? UIView
        } else {return nil}
    }
}

