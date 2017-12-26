//
//  ZLCommunityViewController.swift
//  Zealer
//
//  Created by ZJQian on 2017/12/6.
//  Copyright © 2017年 zjq. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import Moya
import SwiftyJSON

private let dispose = DisposeBag()
class ZLCommunityViewController: ZLBaseViewController {

    let provider = MoyaProvider<APIManager>()
    var dataArray = Array<Any>()
    var dialog: SelectNameDialog?
    var selectName: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setNavi()
        setSubViews()
    }

    fileprivate func setNavi() {
        showBackItem(show: false)
        naviTitle = "朴树"
        showRightItem(imageName: "angle-down")
        selectName = "朴树"
    }
    
    fileprivate func setSubViews() {
        
        zlTableView.frame = CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT-64)
        zlTableView.rowHeight = 80.0
        zlTableView.backgroundColor = UIColor.clear
        zlTableView.separatorInset = .zero
        view.addSubview(zlTableView)
        showHeaderRefresh(show: true) {
            
            self.getData(withName: self.selectName!)
        }
        zlTableView.mj_header.beginRefreshing()
        
    }
    
    fileprivate func getData(withName name: String) {
        
        provider.rx
            .request(.music_list(key: name))
            .filterSuccessfulStatusCodes()
            .mapJSON()
            .subscribe(onSuccess: { (response) in
                
                let json = JSON.init(response)
                
                self.dataArray = json["musics"].arrayValue
                self.zlTableView.mj_header.endRefreshing()
                self.zlTableView.reloadData()
                DLog(message: response)
            }) { (error) in
                
                self.zlTableView.mj_header.endRefreshing()
                
                DLog(message: error)
            }.disposed(by: dispose)
        
    }
    
    override func rightItemAction() {
        super.rightItemAction()
        
        if dialog == nil {
            
            dialog = SelectNameDialog.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT), rightView: (self.navigationItem.rightBarButtonItem?.customView)!)
            dialog?.delegate = self as SelectNameDialogDelegate
            dialog?.hideCallBack = {
                self.dialog = nil
            }
            view.addSubview(dialog!)
            dialog?.show()
        }else{
            
            dialog?.hide()
            dialog?.hideCallBack = {
                self.dialog = nil
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellID = "musicItemCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID) as? MusicItemCell
        if cell == nil {
            
            cell = Bundle.main.loadNibNamed("MusicItemCell", owner: nil, options: nil)?.first as? MusicItemCell
        }
        cell?.setData(json: self.dataArray[indexPath.row] as! JSON)
        return cell!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ZLCommunityViewController: SelectNameDialogDelegate {
    func selectName(dialog: SelectNameDialog, name: String) {
        
        selectName = name
        naviTitle = name
        zlTableView.mj_header.beginRefreshing()
    }
}

