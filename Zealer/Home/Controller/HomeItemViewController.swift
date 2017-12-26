//
//  HomeItemViewController.swift
//  Zealer
//
//  Created by ZJQian on 2017/12/7.
//  Copyright © 2017年 zjq. All rights reserved.
//

import UIKit
import Moya
import RxSwift
import RxCocoa
import SwiftyJSON

protocol HomeItemViewControllerDelegate {
    func didSelectedItem(withIndex index: Int)
}

private let dispose = DisposeBag()

class HomeItemViewController: ZLBaseViewController {

    let provider = MoyaProvider<APIManager>()
    var dataArray = Array<Any>()
    var api_type: APIManager?
    var index: Int?
    var delegate: HomeItemViewControllerDelegate?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        zlTableView.frame = CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT-49-64)
        zlTableView.rowHeight = 150.0
        zlTableView.backgroundColor = UIColor.clear
        zlTableView.separatorInset = .zero
        view.addSubview(zlTableView)
        showHeaderRefresh(show: true) {
            
            self.getData()
        }
        zlTableView.mj_header.beginRefreshing()
        
    }
    
    fileprivate func getData() {
    
        provider.rx
            .request(api_type!)
            .filterSuccessfulStatusCodes()
            .mapJSON()
            .subscribe(onSuccess: { (response) in
                
                
                let json = JSON.init(response)
                
                self.dataArray = json["subjects"].arrayValue
                self.zlTableView.mj_header.endRefreshing()
                self.zlTableView.reloadData()
                DLog(message: response)
            }) { (error) in
                
                self.zlTableView.mj_header.endRefreshing()
                DLog(message: error)
            }.disposed(by: dispose)
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if index == 3 {
            
            let cellID = "usBoxCell"
            var cell = tableView.dequeueReusableCell(withIdentifier: cellID) as? USBoxCell
            if cell == nil {
                
                cell = Bundle.main.loadNibNamed("USBoxCell", owner: nil, options: nil)?.first as? USBoxCell
            }
            cell?.setData(json: self.dataArray[indexPath.row] as! JSON)
            return cell!
        }else{
            
            let cellID = "homeItemCell"
            var cell = tableView.dequeueReusableCell(withIdentifier: cellID) as? HomeItemCell
            if cell == nil {
                
                cell = Bundle.main.loadNibNamed("HomeItemCell", owner: nil, options: nil)?.first as? HomeItemCell
            }
            cell?.setData(dic: self.dataArray[indexPath.row] as! JSON)
            return cell!
        }
        
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        super.tableView(tableView, didSelectRowAt: indexPath)
        
        delegate?.didSelectedItem(withIndex: indexPath.row)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
