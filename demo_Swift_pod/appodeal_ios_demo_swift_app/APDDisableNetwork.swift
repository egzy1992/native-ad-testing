//
//  APDDisableNetwork.swift
//  appodeal_ios_demo_swift_app
//
//  Created by Lozhkin Ilya on 11/22/16.
//  Copyright © 2016 Lozhkin Ilya. All rights reserved.
//

import UIKit

class APDDisableNetwork: APDRootViewController, UITableViewDelegate, UITableViewDataSource {
    
    var appodealDisableNetworkView : APDDisableNetworkView!
    var networks : [NSDictionary] = []
    var disabledNetworks: NSMutableArray = NSMutableArray();
    var disabledAll : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networks = self.networPropConfig() as! [NSDictionary]
        
        appodealDisableNetworkView = APDDisableNetworkView.init(frame: self.view.frame)
        appodealDisableNetworkView.tableView.delegate = self;
        appodealDisableNetworkView.tableView.dataSource = self;
        appodealDisableNetworkView.tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier:"cellWithAccessory")
        appodealDisableNetworkView.tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "next")
        
        self.view = appodealDisableNetworkView;
    }
    
    func networPropConfig() -> NSArray {
        let propArray = [["None"        : ""],
                         ["AdColony"    : "adcolony"],
                         ["Google"      : "admob"],
                         ["Amazon"      : "amazon_ads"],
                         ["Applovin"    : "applovin"],
                         ["Avocarrot"   : "avocarrot"],
                         ["Chartboost"  : "chartboost"],
                         ["Facebook"    : "facebook"],
                         ["Flurry"      : "flurry"],
                         ["Inmobi"      : "inmobi"],
                         ["InnerActive" : "inner-active"],
                         ["Twitter"     : "mopub"],
                         ["OpenX"       : "openx"],
                         ["Pubnative"   : "pubnative"],
                         ["Smaato"      : "smaato"],
                         ["SpotX"       : "spotx"],
                         ["StartApp"    : "startapp"],
                         ["Mail.ru"     : "mailru"],
                         ["Tapjoy"      : "tapjoy"],
                         ["Tapsense"    : "tapsense"],
                         ["Unity"       : "unity_ads"],
                         ["Vungle"      : "vungle"],
                         ["Yandex"      : "yandex"],
                         ["Zplay"       : "zplay"],
                         ["Appodeal"    : "appodeal"],
                         ["Mraid"       : "mraid"],
                         ["Vast"        : "vast"]]
        
        return propArray as NSArray
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
        case 0: enabledAll(flag : isOn); break
        case 1: disableWithIndex(index: indexPath); break
        case 2: break
        default : break
        }
    }
    
    //MARK: --- Table
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : section == 1 ? networks.count : 1;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellName : String = indexPath.section != 2 ? "cellWithAccessory" : "next"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellName, for: indexPath)
        
        let flag : Bool = indexPath.section == 0 ? self.disabledAll : indexPath.section == 1 ? disabledNetworks.contains(networks[indexPath.row].allValues.first!) : false

        let text : String =  indexPath.section == 0 ? "disable all" : indexPath.section == 1 ? networks[indexPath.row].allKeys.first as! String : "continue";
        
        
        
        let attributesMainText : [String : Any] = [NSForegroundColorAttributeName: UIColor.black,
            NSFontAttributeName: UIFont.init(name: "HelveticaNeue", size: 16)!,
            NSKernAttributeName: 1.2]
        
        cell.textLabel?.attributedText = NSAttributedString.init(string: text, attributes: attributesMainText)

        if (indexPath.section != 2) {
            cell.accessoryView = switchWith(IndexPath: indexPath, andCheck: flag)
        } else {
            cell.textLabel?.textAlignment = NSTextAlignment.center;
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.section == 2) {
            segueToNextController();
        }
    }
    
    //MARK: -- Support
    
    func enabledAll(flag : Bool) {
        disabledAll = flag
        disabledNetworks = []
        if !flag {
            appodealDisableNetworkView.tableView.reloadData()
            return
        }
        
        for dict in networks {
            disabledNetworks.add(dict.allValues.first!)
        }
        appodealDisableNetworkView.tableView.reloadData()
    }
    
    func disableWithIndex(index : IndexPath){
        if disabledNetworks.contains(networks[index.row].allValues.first!) {
           disabledNetworks.remove(networks[index.row].allValues.first!)
        } else {
            disabledNetworks.add(networks[index.row].allValues.first!)
        }
    }
    
    func segueToNextController() {
        (UIApplication.shared.delegate as! AppDelegate!).disabledNetworks = disabledNetworks;
        
        let nextController : APDAppodealConfiguration! = APDAppodealConfiguration();
        nextController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve;
        self.navigationController?.pushViewController(nextController, animated: true)
    }
}

class APDDisableNetworkView: APDRootView {
    
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
