//
//  ZLSettingViewController.swift
//  Zealer
//
//  Created by ZJQian on 2017/12/6.
//  Copyright © 2017年 zjq. All rights reserved.
//

import UIKit


class ZLSettingViewController: ZLBaseViewController {

    let titleArray = ["清除缓存","关于我们","意见反馈","安全设置"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        naviTitle = "设置"
        zlTableView.backgroundColor = UIColor.clear
        zlTableView.rowHeight = 50.0
        zlTableView.isScrollEnabled = false
        view.addSubview(zlTableView)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = "settingCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: cellID)
        }
        cell?.textLabel?.text = titleArray[indexPath.row]
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        super.tableView(tableView, didSelectRowAt: indexPath)
        
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "privacy") as! ZLPrivacyViewController
        navigationController?.pushViewController(vc, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
