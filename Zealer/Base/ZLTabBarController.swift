//
//  ZLTabBarController.swift
//  Zealer
//
//  Created by ZJQian on 2017/12/6.
//  Copyright © 2017年 zjq. All rights reserved.
//

import UIKit

class ZLTabBarController: UITabBarController {

    let titleArray = ["电影","音乐","我"]
    let normal_imgArray = ["tab_home_normal","tab_community_normal","tab_me_normal"]
    let select_imgArray = ["tab_home_select","tab_community_select","tab_me_select"]
    let vcArray = [ZLHomeViewController(),ZLCommunityViewController(),ZLUserViewController()]
    var navArray = Array<Any>()
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setControllers()
    }
    
    fileprivate func setControllers() {
        
        for index in 0..<titleArray.count {
            
            let nav = ZLBaseNavigationController.init(rootViewController: vcArray[index])
            nav.tabBarItem.title = titleArray[index]
            nav.tabBarItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: TABBAR_COLOR], for: .selected)
            nav.tabBarItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: TABBAR_COLOR], for: .normal)
            nav.tabBarItem.image = UIImage(named: normal_imgArray[index])?.withRenderingMode(.alwaysOriginal)
            nav.tabBarItem.selectedImage = UIImage(named: select_imgArray[index])?.withRenderingMode(.alwaysOriginal)
            navArray.append(nav)
        }
        
        viewControllers = navArray as? [UIViewController]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
