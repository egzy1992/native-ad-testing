//
//  APDUserDataConfiguration.swift
//  appodeal_ios_demo_swift_app
//
//  Created by Lozhkin Ilya on 2/15/17.
//  Copyright © 2017 Lozhkin Ilya. All rights reserved.
//

import UIKit

class APDUserDataConfiguration: APDVisualRootViewController, UITableViewDelegate, UITableViewDataSource {

    var appodealUserDataConfigurationView : APDUserDataConfigurationView!
    var userData: APDUserDataModel! = (UIApplication.shared.delegate as! AppDelegate!).userData
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appodealUserDataConfigurationView = APDUserDataConfigurationView.init(frame: self.view.frame)
        appodealUserDataConfigurationView.tableView.delegate = self;
        appodealUserDataConfigurationView.tableView.dataSource = self;
        appodealUserDataConfigurationView.tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier:"cellWithAccessory")
        appodealUserDataConfigurationView.tableView.register(APDUserDataDescriptionCell.classForCoder(), forCellReuseIdentifier:"cellWithDescription")
        
        self.view = appodealUserDataConfigurationView;
    }
    
    //MARK: --- SWITCH_CONTROLL
    
    func switchWith(IndexPath indexPath : IndexPath, andCheck check : Bool) -> UISwitch {
        let swith : UISwitch = UISwitch.init()
        swith.isOn = check
        swith.addTarget(self, action: #selector(swithChanged), for: UIControlEvents.valueChanged)
        swith.tag = self.tagWithIndexPath(indexPath)
        return swith
    }
    
    func tagWithIndexPath(_ indexPath : IndexPath) -> Int {
        return (indexPath as NSIndexPath).section * 1000 + (indexPath as NSIndexPath).row
    }
    
    func indexPathFromTag(_ tag : Int) -> IndexPath {
        return IndexPath.init(row: tag % 1000, section: tag / 1000)
    }
    
    //MARK: --- SWITCH_SELECTED
    
    func swithChanged(_ sender : AnyObject) {
        if !(sender is UISwitch) {
            return
        }
        let isOn : Bool = (sender as! UISwitch).isOn
        let indexPath : IndexPath = self.indexPathFromTag((sender as! UISwitch).tag)
        
        switch (indexPath as NSIndexPath).section {
        case 0: userData.userSettings = isOn; break
//        case 1: disableWithIndex(index: indexPath); break
//        case 2: break
        default : break
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : 10;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellName : String = indexPath.section == 0 ? "cellWithAccessory" : "cellWithDescription"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellName, for: indexPath)
        
        let flag : Bool = indexPath.section == 0 ? userData.userSettings : false
        
        var text : String =  indexPath.section == 0 ? "user data" : ""
        var description : String = ""
        
        if (indexPath.section != 0) {
            switch indexPath.row {
            case 0: text = "userId";  description = "d";       break
            case 1: text = "Email";   description = "d";       break
            case 2: text = "BirthDay";description = "d\nf\ns\ns";       break
            case 3: text = "Age";      description = "d";      break
            case 4: text = "Gender";   description = "d";      break
            case 5: text = "Occupation";description = "d";     break
            case 6: text = "Relationship";description = "d";   break
            case 7: text = "Smoking";     description = "d";   break
            case 8: text = "Alcohol";     description = "d";   break
            case 9: text = "Interests";   description = "d";   break
            default: text = "";
            }
        }
        
        let attributesMainText : [String : Any] = [NSForegroundColorAttributeName: UIColor.black,
                                                   NSFontAttributeName: UIFont.init(name: "HelveticaNeue", size: 16)!,
                                                   NSKernAttributeName: 1.2]
        
        cell.textLabel?.attributedText = NSAttributedString.init(string: text, attributes: attributesMainText)
        cell.detailTextLabel?.text = description
        
        if (indexPath.section == 0) {
            cell.accessoryView = switchWith(IndexPath: indexPath, andCheck: flag)
        } else {
            cell.textLabel?.textAlignment = NSTextAlignment.center;
        }
        
        cell.setNeedsUpdateConstraints()
        cell.updateConstraintsIfNeeded()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

class APDUserDataConfigurationView: APDRootView {
    
    var tableView : UITableView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        tableView = UITableView.init(frame: self.frame, style: UITableViewStyle.plain)
        tableView.contentInset = UIEdgeInsetsMake(0, 0, 50, 0)
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedSectionHeaderHeight = 44.0
        tableView.sectionHeaderHeight = UITableViewAutomaticDimension
        
        self.addSubview(tableView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class APDUserDataDescriptionCell: UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: UITableViewCellStyle.subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class APDUserDataSelectorWindow: UIWindow {
    
    private var textValue : String?
    
    init(_ text : String){
        super.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100));
        textValue = text
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
