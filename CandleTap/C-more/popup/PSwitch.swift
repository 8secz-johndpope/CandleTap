/*🔥CandleTap_PSwitch💧*/import UIKit

class PopupSwitchView: UIView {
    
    var popupSwitch: UISwitch = {
        let popupSwitch = UISwitch();       var switchColour = defaultSwitchColour
        popupSwitch.tintColor = switchColour
        popupSwitch.thumbTintColor = switchColour
        popupSwitch.onTintColor = iosSettingsGray
        popupSwitch.addTarget(self, action: #selector(switchFlipped), for: .valueChanged)
        popupSwitch.translatesAutoresizingMaskIntoConstraints = false
        return popupSwitch
    }()
    
    let popupLabel: UILabel = {
        let label = UILabel()
        label.text = "Recurring?"
        label.font = UIFont.systemFont(ofSize: 12, weight: .thin)//defaultTimetableCellFont
        label.backgroundColor = .clear
        label.textColor = defaultTextColour
        label.numberOfLines = 1
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {  super.init(frame: frame)
        addSubview(popupSwitch);    addSubview(popupLabel)
        let quarterHeight = self.frame.height / 4
        /**/
        addConstraint(NSLayoutConstraint(item: popupSwitch, attribute: .centerY, relatedBy: .equal,
                                         toItem: self, attribute: .centerY, multiplier: 1, constant: quarterHeight / 2))
        
        addConstraint(NSLayoutConstraint(item: popupLabel, attribute: .centerY, relatedBy: .equal,
                                         toItem: self, attribute: .centerY, multiplier: 1, constant: -quarterHeight))
        
        addConstraint(NSLayoutConstraint(item: popupSwitch, attribute: .centerX, relatedBy: .equal,
                                         toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        
        addConstraint(NSLayoutConstraint(item: popupLabel, attribute: .centerX, relatedBy: .equal,
                                         toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        
        popupSwitch.isOn = globalSwitchBool
    }
    
    @objc func switchFlipped(mySwitch: UISwitch, switchBool: Bool) {
        if mySwitch.isOn {globalSwitchBool = true} else {globalSwitchBool = false}
    }
    
    required init?(coder aDecoder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}

