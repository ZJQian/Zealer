//
//  ZLBaseViewController.swift
//  Zealer
//
//  Created by ZJQian on 2017/12/6.
//  Copyright © 2017年 zjq. All rights reserved.
//

import UIKit
import MJRefresh


class ZLBaseViewController: UIViewController {

    var refreshImgArray = Array<UIImage>()
    
    lazy var tableView: UITableView = {
        let table = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT), style: .plain)
        table.tableFooterView = UIView.init()
        table.delegate = self as UITableViewDelegate
        table.dataSource = self as UITableViewDataSource
        return table
    }()
    
    var naviTitle: String?{
        
        willSet{
            
        }
        didSet{
            
            let lb = UILabel.init()
            lb.text = naviTitle
            lb.sizeToFit()
            lb.font = UIFont.systemFont(ofSize: 18.0)
            lb.textColor = UIColor.white
            lb.textAlignment = .center
            navigationItem.titleView = lb
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        view.backgroundColor = BG_COLOR
        showBackItem(show: true)
        
        for index in 1...63 {
            let img = UIImage.init(named: "refresh-\(index)")
            refreshImgArray.append(img!)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    public func showHeaderRefresh(show: Bool, refresh : @escaping () -> ()) {
        if show {
            
            let header = MJRefreshGifHeader.init(refreshingBlock: {
                
                refresh()
            })
            header?.setImages(refreshImgArray, duration: 1, for: .idle)
            header?.setImages(refreshImgArray, duration: 1, for: .pulling)
            header?.setImages(refreshImgArray, duration: 1, for: .refreshing)
            header?.lastUpdatedTimeLabel.isHidden = true
            header?.stateLabel.isHidden = true
            tableView.mj_header = header
        }
    }
    
    public func showFooterRefresh(show: Bool, refresh: @escaping() -> ()){
        if show {
            
            tableView.mj_footer = MJRefreshBackStateFooter.init(refreshingBlock: {
                
                refresh()
            })
        }
    }
    
    
    /// 展示返回按钮(默认展示)
    ///
    public func showBackItem(show: Bool) {
        
        if show {
            let back_item = UIBarButtonItem.init(title: "", style: .plain, target: nil, action: #selector(leftItemAction))
            navigationController?.navigationBar.tintColor = UIColor.white
            navigationController?.navigationBar.backIndicatorImage = UIImage(named:"nav_back")
            navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named:"nav_back")
            navigationItem.backBarButtonItem = back_item
        }else{
            
            navigationItem.hidesBackButton = true
        }
        
    }
    
    
    /// 展示带 title 的 leftItem
    ///
    /// - Parameter title: title
    public func showLeftItem(title: String) {
        
        let btn_left = UIButton.init(type: .custom)
        btn_left.setTitle(title, for: .normal)
        btn_left.titleLabel?.font = UIFont.systemFont(ofSize: 15.0)
        btn_left.titleLabel?.sizeToFit()
        btn_left.setTitleColor(UIColor.white, for: .normal)
        btn_left.addTarget(self, action: #selector(leftItemAction), for: .touchUpInside)
        let left = UIBarButtonItem.init(customView: btn_left)
        navigationItem.rightBarButtonItem = left
    }
    
    /// 展示带 title 的 rightItem
    ///
    /// - Parameter title:  标题
    public func showRightItem(title: String) {
        
        let btn_right = UIButton.init(type: .custom)
        btn_right.setTitle(title, for: .normal)
        btn_right.titleLabel?.font = UIFont.systemFont(ofSize: 15.0)
        btn_right.titleLabel?.sizeToFit()
        btn_right.setTitleColor(UIColor.white, for: .normal)
        btn_right.addTarget(self, action: #selector(rightItemAction), for: .touchUpInside)
        let right = UIBarButtonItem.init(customView: btn_right)
        navigationItem.rightBarButtonItem = right
    }
    
    
    /// 展示带图片名称的 rightItem
    ///
    /// - Parameter imageName:  图片名称
    public func showRightItem(imageName: String) {
        
        let btn_right = UIButton.init(type: .custom)
        btn_right.frame = CGRect.init(x: 0, y: 0, width: 20, height: 20)
        btn_right.setImage(UIImage.init(named: imageName), for: .normal)
        btn_right.setTitleColor(UIColor.white, for: .normal)
        btn_right.addTarget(self, action: #selector(rightItemAction), for: .touchUpInside)
        let right = UIBarButtonItem.init(customView: btn_right)
        navigationItem.rightBarButtonItem = right
    }
    
    //MARK: EVENT
    
    /// 返回按钮点击事件
    @objc public func leftItemAction() {
        
        navigationController?.popViewController(animated: true)
    }
    
    /// rightItem 的点击事件
    @objc func rightItemAction() {
        
    }
}

extension ZLBaseViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = "cellID"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        if !(cell != nil) {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: cellID)
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

