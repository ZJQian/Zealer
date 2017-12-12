//
//  ZLUserViewController.swift
//  Zealer
//
//  Created by ZJQian on 2017/12/6.
//  Copyright © 2017年 zjq. All rights reserved.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift
import SDWebImage

private let dispose = DisposeBag()

class ZLUserViewController: ZLBaseViewController {

    
    var iv_head = UIImageView()
    var lb_state = UILabel()
    
    
    let titleArray = ["我的帖子","我的收藏","我的小组","我的消息","我的通知"]
    let imgArray = ["user_tiezi","user_collect","user_xiaozu","user_msg","user_noti"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        navigationController?.delegate = self
        tableView.frame = CGRect.init(x: 0, y: -20, width: SCREEN_WIDTH, height: SCREEN_HEIGHT+20)
        tableView.separatorInset = .zero
        tableView.backgroundColor = UIColor.clear
        tableView.rowHeight = 50.0
        view.addSubview(tableView)
        showHeaderRefresh(show: true) {
            
            DispatchQueue.main.asyncAfter(deadline: .now()+2, execute: {
                self.tableView.mj_header.endRefreshing()
            })
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = "userCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: cellID)
        }
        cell?.textLabel?.text = titleArray[indexPath.row]
        cell?.imageView?.image = UIImage(named: imgArray[indexPath.row])
        cell?.accessoryType = .disclosureIndicator
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 200.0
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let v = UIView()
        v.backgroundColor = NAVI_COLOR
        
        let btn_setting = UIButton.init(type: .custom)
        btn_setting.setImage(UIImage.init(named: "settings"), for: .normal)
        btn_setting.rx.tap.subscribe { (sender) in
            
            let vc = ZLSettingViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            
        }.disposed(by: dispose)
        v.addSubview(btn_setting)
        btn_setting.snp.makeConstraints { (make) in
            make.right.equalTo(-17)
            make.top.equalTo(30)
        }
        
        
        iv_head.isUserInteractionEnabled = true
        if UserInfoUtils.isLogin() {
            
            iv_head.sd_setImage(with: URL.init(string: "https://img1.doubanio.com/spic/s29477089.jpg"), placeholderImage: UIImage(named: "user_head"), options: SDWebImageOptions.scaleDownLargeImages, completed: nil)
        }else{
            iv_head.image = UIImage(named: "user_head")
        }
        iv_head.setRadius(radius: 70/2)
        v.addSubview(iv_head)
        iv_head.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.height.equalTo(70)
        }
        
        let tap_gesture = UITapGestureRecognizer()
        iv_head.addGestureRecognizer(tap_gesture)
        tap_gesture.rx.event.subscribe { (tap) in
            
            if !UserInfoUtils.isLogin() {
               self.goLogin()
            }
        }.disposed(by: dispose)
        
        
        lb_state.text =  UserInfoUtils.isLogin() ? "用户"+String(format: "%d",arc4random()%100):"未登录"
        lb_state.textColor = UIColor.white
        lb_state.textAlignment = .center
        lb_state.sizeToFit()
        v.addSubview(lb_state)
        lb_state.snp.makeConstraints { (make) in
            make.top.equalTo(iv_head.snp.bottom).offset(15)
            make.centerX.equalTo(iv_head)
        }
        
        return v
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        super.tableView(tableView, didSelectRowAt: indexPath)
        
        if !UserInfoUtils.isLogin() {
            
            goLogin()
        }else{
            
            WarnDialog.showWarnDialog(warnString: titleArray[indexPath.row])
        }
    }

    fileprivate func goLogin() {
        
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "login") as! ZLBaseNavigationController
        let loginVC = vc.topViewController as! ZLLoginViewController
        loginVC.loginSuccessCallback = {
            
            DLog(message: "登录成功")
            self.iv_head.sd_setImage(with: URL.init(string: "https://img1.doubanio.com/spic/s29477089.jpg"), placeholderImage: UIImage(named: "user_head"), options: SDWebImageOptions.scaleDownLargeImages, completed: nil)
            self.lb_state.text = "用户"+String(format: "%d",arc4random()%100)
        }
        self.present(vc, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}



extension ZLUserViewController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        
        let isShow = viewController.isKind(of: ZLUserViewController.self as AnyClass)
        navigationController.setNavigationBarHidden(isShow, animated: true)
    }
}
