//
//  APDAppodealConfiguration.swift
//  appodeal_ios_demo_swift_app
//
//  Created by Lozhkin Ilya on 9/8/16.
//  Copyright © 2016 Lozhkin Ilya. All rights reserved.
//

import UIKit
import Appodeal

class APDAppodealConfiguration: APDRootViewController, UITableViewDelegate, UITableViewDataSource{

    var appodealConfigurationView : APDAppodealConfigurationView!
    var _cellDictName : NSMutableDictionary = NSMutableDictionary()
    var _cellDescriptionName : NSMutableDictionary = NSMutableDictionary()
    var _cellHeaderName : NSMutableDictionary = NSMutableDictionary()
    var _enableModules : NSMutableDictionary = NSMutableDictionary()
    var _adModules : NSArray = []
    
    var _locationPermition : Bool! = true
    var _autoCache : Bool! = true
    var _userData : Bool! = false
    var _testMode : Bool! = false
    var _debugMode : Bool! = false
    var _toastMode : Bool! = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appodealConfigurationView = APDAppodealConfigurationView.init(frame: self.view.frame)
        appodealConfigurationView.tableView.delegate = self;
        appodealConfigurationView.tableView.dataSource = self;
        appodealConfigurationView.tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier:"cellWithAccessory")
        appodealConfigurationView.tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "initialize")
        
        _cellDictName = self.cellDictName()
        _cellDescriptionName = self.cellDescriptionName()
        _cellHeaderName = self.cellHeaderName()
        _enableModules = self.enabledModules()
        
        self.view = appodealConfigurationView
    }
    
    //MARK: --- CELL_NAME
    
    func cellDictName() -> NSMutableDictionary {
        let dict : NSMutableDictionary = [
            self.i_Ps(0, index: 0) : NSLocalizedString("banner", comment: ""),
            self.i_Ps(0, index: 1) : NSLocalizedString("interstitial ad", comment: ""),
            self.i_Ps(0, index: 2) : NSLocalizedString("skippable video", comment: ""),
            self.i_Ps(0, index: 3) : NSLocalizedString("rewarded video", comment: ""),
            self.i_Ps(0, index: 4) : NSLocalizedString("native ads", comment: ""),
            self.i_Ps(0, index: 5) : NSLocalizedString("MREC", comment: ""),
            self.i_Ps(1, index: 0) : NSLocalizedString("disable location permition check", comment: ""),
            self.i_Ps(1, index: 1) : NSLocalizedString("set auto cache", comment: ""),
            self.i_Ps(1, index: 2) : NSLocalizedString("user data", comment: ""),
            self.i_Ps(2, index: 0) : NSLocalizedString("test mode", comment: ""),
            self.i_Ps(2, index: 1) : NSLocalizedString("toast mode", comment: ""),
            self.i_Ps(3, index: 0) : NSLocalizedString("Initialize", comment: "")]
        
        _adModules = [
            NSNumber(value : AppodealAdType.banner.rawValue),
            NSNumber(value : AppodealAdType.interstitial.rawValue),
            NSNumber(value : AppodealAdType.skippableVideo.rawValue),
            NSNumber(value : AppodealAdType.rewardedVideo.rawValue),
            NSNumber(value : AppodealAdType.nativeAd.rawValue),
            NSNumber(value : AppodealAdType.MREC.rawValue)]
    
        _cellDictName = dict
        return _cellDictName
    }
    
    func cellDescriptionName() -> NSMutableDictionary {
        let dict : NSMutableDictionary = [
            self.i_Ps(0, index: 0) : NSLocalizedString("/* [Appodeal disableNetworkForAdType:AppodealAdTypeBanner name:@\"networkName\"] */", comment: ""),
            self.i_Ps(0, index: 1) : NSLocalizedString("/* [Appodeal disableNetworkForAdType:AppodealAdTypeInterstitial name:@\"networkName\"] */", comment: ""),
            self.i_Ps(0, index: 2) : NSLocalizedString("/* [Appodeal disableNetworkForAdType:AppodealAdTypeSkippableVideo name:@\"networkName\"] */", comment: ""),
            self.i_Ps(0, index: 3) : NSLocalizedString("/* [Appodeal disableNetworkForAdType:AppodealAdTypeRewardedVideo name:@\"networkName\"] */", comment: ""),
            self.i_Ps(0, index: 4) : NSLocalizedString("/* [Appodeal disableNetworkForAdType:AppodealAdTypeNativeAd name:@\"networkName\"] */", comment: ""),
            self.i_Ps(0, index: 5) : NSLocalizedString("/* [Appodeal disableNetworkForAdType:AppodealAdTypeMREC name:@\"networkName\"] */", comment: "")]
        _cellDescriptionName = dict
        return _cellDescriptionName
    }
    
    func cellHeaderName() -> NSMutableDictionary {
        let dict : NSMutableDictionary = [
            0 : NSLocalizedString("ad modules", comment: ""),
            1 : NSLocalizedString("advanced", comment: ""),
            2 : NSLocalizedString("debug", comment: "")]
        _cellHeaderName = dict
        return _cellHeaderName
    }
    
    func i_Ps(_ section : Int, index : Int) ->  IndexPath{
        return IndexPath.init(row: index, section: section)
    }
    
    func enabledModules() -> NSMutableDictionary {
        let dict : NSMutableDictionary = NSMutableDictionary()
        var index : Int = 0
        for obj in _adModules {
            dict[self.i_Ps(0, index: index)] = obj
            index += 1
        }
        _enableModules = dict
        return _enableModules
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
        return (indexPath as NSIndexPath).section * 10 + (indexPath as NSIndexPath).row
    }
    
    func indexPathFromTag(_ tag : Int) -> IndexPath {
        return IndexPath.init(row: tag % 10, section: tag / 10)
    }
    
    //MARK: --- SWITCH_SELECTED
    
    func swithChanged(_ sender : AnyObject) {
        if !(sender is UISwitch) {
            return
        }
        
        let indexPath : IndexPath = self.indexPathFromTag((sender as! UISwitch).tag)
        switch (indexPath as NSIndexPath).section {
        case 0:
            if _adModules.count > (indexPath as NSIndexPath).row {
                _enableModules[indexPath] = (sender as! UISwitch).isOn ? _adModules[indexPath.row] : nil
            }
            break
        case 1:
            switch (indexPath as NSIndexPath).row {
            case 0: _locationPermition = (sender as! UISwitch).isOn; break
            case 1: _autoCache =  (sender as! UISwitch).isOn; break
            case 2: _userData =  (sender as! UISwitch).isOn; break
            default : break
            }; break
        case 2:
            switch (indexPath as NSIndexPath).row {
            case 0: _testMode = (sender as! UISwitch).isOn; break
            case 1: _toastMode =  (sender as! UISwitch).isOn; break
            default : break
            }; break

        default : break
        }
    }
    
    //MARK: UITableViewDelegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? _enableModules.count : section == 1 ? 3 : section == 2 ? 2 : 1;
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if _cellHeaderName[section] == nil {
            return nil;
        }
        return appodealConfigurationView.headerView(withTitle: (_cellHeaderName[section] as! String),
                                                    tintColor: UIColor.black,
                                                    fontSize: 12,
                                                    backgroundColor: UIColor.init(white: 0.95, alpha: 1))
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellName : String = String(describing: self)
        var cell : UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: cellName)
        
        if ((cell == nil)) {
            cell = UITableViewCell.init(style: UITableViewCellStyle.subtitle, reuseIdentifier: cellName)
            cell.selectionStyle = UITableViewCellSelectionStyle.none
        }
        
        if (_cellDictName[indexPath] != nil) {
            cell.textLabel?.attributedText = NSAttributedString.init(string: (_cellDictName[indexPath] as! String),
                                                                     attributes: [
                                                                        NSForegroundColorAttributeName : UIColor.black,
                                                                        NSFontAttributeName : UIFont.systemFont(ofSize: 16),
                                                                        NSKernAttributeName : 1.2])
        }
        
        if (_cellDescriptionName[indexPath] != nil) {
            cell.detailTextLabel?.attributedText = NSAttributedString.init(string: (_cellDescriptionName[indexPath] as! String),
                                                                           attributes: [
                                                                            NSForegroundColorAttributeName : UIColor.lightGray,
                                                                            NSFontAttributeName : UIFont.systemFont(ofSize: 12),
                                                                            NSKernAttributeName : 1.0])
        }
        
        switch indexPath.section {
        case 0:
            cell.accessoryView = self.switchWith(IndexPath: indexPath, andCheck: _enableModules[indexPath] != nil ? true : false)
            break;
        case 1:
                switch (indexPath.row) {
                case 0:
                    cell.accessoryView = self.switchWith(IndexPath: indexPath, andCheck: _locationPermition); break
                case 1:
                    cell.accessoryView = self.switchWith(IndexPath: indexPath, andCheck: _autoCache); break
                case 2:
                    cell.accessoryView = self.switchWith(IndexPath: indexPath, andCheck: _userData); break
                default : break
                }; break
        case 2:
            switch (indexPath.row) {
            case 0:
                cell.accessoryView = self.switchWith(IndexPath: indexPath, andCheck: _testMode); break
            case 1:
                cell.accessoryView = self.switchWith(IndexPath: indexPath, andCheck: _toastMode); break
            default : break
            }; break
        case 3:
                switch (indexPath.row) {
                case 0:
                        if _cellDictName[indexPath] == nil {
                            break
                        }
                        
                        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
                        cell.textLabel?.attributedText = NSAttributedString.init(string: (_cellDictName[indexPath] as! String),
                                                                                 attributes: [
                                                                                    NSForegroundColorAttributeName : UIColor.red,
                                                                                    NSFontAttributeName : UIFont.systemFont(ofSize: 16),
                                                                                    NSKernAttributeName : 1.0]) ; break
                default : break
                }; break
        default : break
        }
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 3 {
            if _enableModules.count == 0 {
                return;
            }
            var bitMask : Int = 0
            for module in _enableModules.allValues {
                bitMask = bitMask + (module as AnyObject).intValue
            }
            
            let appodealAdType : AppodealAdType = [AppodealAdType(rawValue: bitMask)]
            
            (UIApplication.shared.delegate as! AppDelegate).initializeSdk(withAdType: appodealAdType, testMode: _testMode, locationTracking: _locationPermition, autoCache: _autoCache, userData: _userData, toastMode: _toastMode)
        }
    }
}

class APDAppodealConfigurationView: APDRootView {
    
    var tableView : UITableView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        tableView = UITableView.init(frame: self.frame, style: UITableViewStyle.plain)
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
