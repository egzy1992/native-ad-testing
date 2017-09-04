//
//  APDAppodealBanner.swift
//  appodeal_ios_demo_swift_app
//
//  Created by Lozhkin Ilya on 9/9/16.
//  Copyright © 2016 Lozhkin Ilya. All rights reserved.
//

import UIKit
import Appodeal

class APDAppodealBanner: APDRootViewController, UITableViewDataSource, UITableViewDelegate {
    
    var appodealBannerViewModel : APDAppodealBannerViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Appodeal.setBannerDelegate(self)
        
        appodealBannerViewModel = APDAppodealBannerViewModel.init(frame: self.view.frame)
        appodealBannerViewModel.tableView.delegate = self
        appodealBannerViewModel.tableView.dataSource = self
        
        self.view = appodealBannerViewModel
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 2 : 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellName : String = String(describing: self)
        var cell : UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: cellName)
        
        if ((cell == nil)) {
            cell = UITableViewCell.init(style: UITableViewCellStyle.subtitle, reuseIdentifier: cellName)
            cell.selectionStyle = UITableViewCellSelectionStyle.none
        }
        
        var cellText : String = ""
        
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0: cellText = "banner top"; break
            case 1: cellText = "banner bottom"; break
            default:break
            }; break
        case 1:
            switch indexPath.row {
            case 0: cellText = "banner in table header"; break
            case 1: cellText = "banner in table cell"; break
            default:break
            }; break
        default:break
        }
        
        cell.textLabel?.attributedText = NSAttributedString.init(string: NSLocalizedString(cellText, comment: ""),
                                                                 attributes: [
                                                                    NSForegroundColorAttributeName : UIColor.black,
                                                                    NSFontAttributeName : UIFont.systemFont(ofSize: 16),
                                                                    NSKernAttributeName : 1.2])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                Appodeal.hideBanner();
                createAlertForPlacement(showStyle: AppodealShowStyle.bannerTop, rootController: self);
                break
            case 1:
                Appodeal.hideBanner();
                createAlertForPlacement(showStyle: AppodealShowStyle.bannerBottom, rootController: self);
                break
            default:break
            }; break
        case 1:
            switch indexPath.row {
            case 0:  break
            case 1:  break
            default:break
            }; break
        default:break
        }
    }
}

extension APDAppodealBanner : AppodealBannerDelegate {
    func bannerDidLoadAdIsPrecache(_ precache: Bool){
        
    }
    func bannerDidLoadAd(){
        
    }
    func bannerDidRefresh(){
        
    }
    func bannerDidFailToLoadAd(){
        
    }
    func bannerDidClick(){
        
    }
    func bannerDidShow(){
        
    }
}

class APDAppodealBannerViewModel: APDRootView {
    var tableView : UITableView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        tableView = UITableView.init(frame: self.frame, style: UITableViewStyle.plain)
        tableView.contentInset = UIEdgeInsetsMake(100, 0, 0, 0)
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
