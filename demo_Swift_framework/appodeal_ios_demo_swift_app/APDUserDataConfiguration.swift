//
//  APDUserDataConfiguration.swift
//  appodeal_ios_demo_swift_app
//
//  Created by Lozhkin Ilya on 2/15/17.
//  Copyright © 2017 Lozhkin Ilya. All rights reserved.
//

import UIKit
import Appodeal

class APDUserDataConfiguration: APDVisualRootViewController, UITableViewDelegate, UITableViewDataSource {

    var appodealUserDataConfigurationView : APDUserDataConfigurationView!
    var userData: APDUserDataModel! = (UIApplication.shared.delegate as! AppDelegate!).userData
    var userSelectorWindow : APDUserDataSelectorWindow!
    
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
            case 0: text = "userId";  description = self.userData.userId;       break
            case 1: text = "Email";   description = self.userData.userEmail;       break
            case 2:
                text = "BirthDay";
                let dateFormatter = DateFormatter();
                dateFormatter.dateFormat = "yyyy-MM-dd";
                description = dateFormatter.string(from: self.userData.userBirthday);
                break
            case 3:
                text = "Age";
                description = String(self.userData.userAge);
                break
            case 4:
                text = "Gender";
                switch (self.userData.userGender) {
                    case AppodealUserGender.male:
                        description = "male";
                        break
                    case AppodealUserGender.female:
                        description = "female";
                        break
                    case AppodealUserGender.other:
                        description = "other";
                        break
                    }
                break
            case 5:
                text = "Occupation";
                switch (self.userData.userOccupation) {
                    case AppodealUserOccupation.school:
                        description = "school";
                        break
                    case AppodealUserOccupation.university:
                        description = "university";
                        break
                    case AppodealUserOccupation.work:
                        description = "work";
                        break
                    case AppodealUserOccupation.other:
                        description = "other";
                        break
                    }
                break
            case 6:
                text = "Relationship";
                switch (self.userData.userRelationship) {
                    case AppodealUserRelationship.engaged:
                        description = "engaged";
                        break
                    case AppodealUserRelationship.married:
                        description = "married";
                        break
                    case AppodealUserRelationship.dating:
                        description = "dating";
                        break
                    case AppodealUserRelationship.other:
                        description = "other";
                        break
                    case AppodealUserRelationship.searching:
                        description = "searching";
                        break
                    case AppodealUserRelationship.single:
                        description = "single";
                        break
                    }
                break
            case 7:
                text = "Smoking";
                switch (self.userData.userSmokingAttitude) {
                    case AppodealUserSmokingAttitude.negative:
                        description = "negative";
                        break
                    case AppodealUserSmokingAttitude.neutral:
                        description = "neutral";
                        break
                    case AppodealUserSmokingAttitude.positive:
                        description = "positive";
                        break
                    }
                break
            case 8:
                text = "Alcohol";
                switch (self.userData.userAlcoholAttitude) {
                    case AppodealUserAlcoholAttitude.negative:
                        description = "negative";
                        break
                    case AppodealUserAlcoholAttitude.neutral:
                        description = "neutral";
                        break
                    case AppodealUserAlcoholAttitude.positive:
                        description = "positive";
                        break
                    }
                break
            case 9:
                text = "Interests";
                description = self.userData.userInterests;
                break
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
        let cellText : String = (tableView.cellForRow(at: indexPath)?.textLabel?.text)!
        userSelectorWindow = APDUserDataSelectorWindow.init(cellText)
        if let userSelectorWindow = userSelectorWindow {
            userSelectorWindow.userData = userData;
            self.view.addSubview(userSelectorWindow)
        }
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

class APDUserDataSelectorWindow: UIView {
    
    private var textValue : String?
    private var inputValueField : UITextField?
    
    public var userData: APDUserDataModel?
    
    init(_ text : String){
        super.init(frame: CGRect(x: (UIScreen.main.bounds.size.width/2 - 150), y: (UIScreen.main.bounds.size.height/2 - 50), width: 300, height: 85));
        self.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.black.cgColor
        createButtonOK(rootView: self)
        createButtonCancel(rootView: self)
        createTextField(rootView: self)
        createCaption(rootView: self, text: text)
        textValue = text
    }
    
    func createCaption(rootView: UIView, text: String) {
        let labelCaption = UILabel.init(frame: CGRect(x: 3, y: 1, width: 100, height: 12))
        labelCaption.font = UIFont.boldSystemFont(ofSize: 8)
        labelCaption.text = text;
        rootView.addSubview(labelCaption)
    }
    
    func createButtonOK(rootView: UIView) {
        let buttonOK = UIButton.init(frame: CGRect(x: 75, y: 50, width: 30, height: 30))
        buttonOK.setTitle("OK", for: UIControlState.normal)
        buttonOK.setTitleColor(#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1), for: UIControlState.highlighted)
        buttonOK.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: UIControlState.normal)
        buttonOK.addTarget(self, action: #selector(buttonOkClicked(sender:)), for: .touchUpInside)
        rootView.addSubview(buttonOK)
    }
    
    func createButtonCancel(rootView: UIView) {
        let buttonCancel = UIButton.init(frame: CGRect(x: 150, y: 50, width: 60, height: 30))
        buttonCancel.setTitle("Cancel", for: UIControlState.normal)
        buttonCancel.setTitleColor(#colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1), for: UIControlState.highlighted)
        buttonCancel.setTitleColor(#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1), for: UIControlState.normal)
        buttonCancel.addTarget(self, action: #selector(buttonCancelClicked(sender:)), for: .touchUpInside)
        rootView.addSubview(buttonCancel)
    }
    
    func createTextField(rootView: UIView) {
        self.inputValueField = UITextField.init(frame: CGRect(x: 25, y: 15, width: 250, height: 30))
        self.inputValueField?.layer.borderWidth = 2
        self.inputValueField?.layer.borderColor = UIColor.black.cgColor
        rootView.addSubview(self.inputValueField!)
    }
    
    @objc func buttonOkClicked(sender: UIButton) {
        let inputValue = (self.inputValueField?.text)!.lowercased()
        switch self.textValue! {
        case "userId":
            self.userData?.userId = inputValue
            break
        case "Email":
            self.userData?.userEmail = inputValue
            break
        case "BirthDay":
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            self.userData?.userBirthday = dateFormatter.date(from:inputValue)!
            break
        case "Age":
            self.userData?.userAge = UInt(inputValue)!
            break
        case "Gender":
            switch inputValue {
                case "other":
                    self.userData?.userGender = AppodealUserGender.other;
                    break
                case "male":
                    self.userData?.userGender = AppodealUserGender.male;
                    break
                case "female":
                    self.userData?.userGender = AppodealUserGender.female;
                    break
                default:
                    break;
            }
            break
        case "Occupation":
            switch inputValue {
                case "other":
                    self.userData?.userOccupation = AppodealUserOccupation.other;
                    break
                case "school":
                    self.userData?.userOccupation = AppodealUserOccupation.school;
                    break
                case "university":
                    self.userData?.userOccupation = AppodealUserOccupation.university;
                    break
                case "work":
                    self.userData?.userOccupation = AppodealUserOccupation.work;
                    break
                default:
                    break;
                }
            break
        case "Relationship":
            switch inputValue {
                case "dating":
                    self.userData?.userRelationship = AppodealUserRelationship.dating;
                    break
                case "engaged":
                    self.userData?.userRelationship = AppodealUserRelationship.engaged;
                    break
                case "single":
                    self.userData?.userRelationship = AppodealUserRelationship.single;
                    break
                case "searching":
                    self.userData?.userRelationship = AppodealUserRelationship.searching;
                    break
                case "other":
                    self.userData?.userRelationship = AppodealUserRelationship.other;
                    break
                case "married":
                    self.userData?.userRelationship = AppodealUserRelationship.married;
                    break
                default:
                    break;
                }
            break
        case "Smoking":
            switch inputValue {
                case "neutral":
                    self.userData?.userSmokingAttitude = AppodealUserSmokingAttitude.neutral;
                    break
                case "positive":
                    self.userData?.userSmokingAttitude = AppodealUserSmokingAttitude.positive;
                    break
                case "negative":
                    self.userData?.userSmokingAttitude = AppodealUserSmokingAttitude.negative;
                    break
                default:
                    break;
                }
            break
        case "Alcohol":
            switch inputValue {
                case "neutral":
                    self.userData?.userAlcoholAttitude = AppodealUserAlcoholAttitude.neutral;
                    break
                case "positive":
                    self.userData?.userAlcoholAttitude = AppodealUserAlcoholAttitude.positive;
                    break
                case "negative":
                    self.userData?.userAlcoholAttitude = AppodealUserAlcoholAttitude.negative;
                    break
                default:
                    break;
                }
            break
        case "Interests":
            self.userData?.userInterests = inputValue
            break
        default:
            break;
        }
        let userConfigurationView = self.superview as? APDUserDataConfigurationView
        userConfigurationView?.tableView.reloadData()
        self.removeFromSuperview()
    }
    @objc func buttonCancelClicked(sender: UIButton) {
        self.removeFromSuperview()
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
