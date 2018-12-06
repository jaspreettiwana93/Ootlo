//
//  SideMenuVC.swift
//  EmergencyContent
//
//  Created by Apple on 22/08/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import MessageUI

class SideMenuVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var mainTableview: UITableView!
    var arrMenus = ["Home",
                    "Latest",
                    "Category",
                    "Author",
                    "Download",
                    "Favorite",
                    "Share App",
                    "Rate App",
                    "More App",
                    "About Us",
                    "Privacy Policy",
                    "Profile",
                    "Logout"]
    
    let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
    
    var selectedItem = 0
    let appThemeBlue = UIColor(displayP3Red: 154.0/255.0, green: 15.0/255.0, blue: 230.0/255.0, alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mainTableview.tableFooterView = UIView()
        mainTableview.delegate = self
        mainTableview.dataSource = self
        
    }

    
    //MARK: TableView Delegates and DataSources
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMenus.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = arrMenus[indexPath.row]
        cell?.textLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        if(selectedItem == indexPath.row)
        {
            cell?.backgroundColor = appThemeBlue
            cell?.textLabel?.textColor = .white
        }
        else
        {
            cell?.backgroundColor = .white
            cell?.textLabel?.textColor = appThemeBlue
        }
        
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        handleSelect(index: indexPath.row)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    //MARK: Custom Actions
    func handleSelect(index: Int)
    {
        selectedItem = index
        mainTableview.reloadData()
        let navController = appDelegate.navBar
        
        
        if(index == 0)
        {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
            navController?.setViewControllers([vc], animated: true)
            appDelegate.sideMenuController.hideLeftView(animated: true, completionHandler: nil)
        }
        
    }
    
}
