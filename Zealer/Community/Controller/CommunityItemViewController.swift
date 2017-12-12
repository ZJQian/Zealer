//
//  CommunityItemViewController.swift
//  Zealer
//
//  Created by ZJQian on 2017/12/8.
//  Copyright © 2017年 zjq. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import Moya

private let dispose = DisposeBag()

class CommunityItemViewController: ZLBaseViewController {

    var type: String?
    let provider = MoyaProvider<APIManager>()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableView.frame = CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT-49-64)
        tableView.rowHeight = 80.0
        tableView.backgroundColor = UIColor.clear
        tableView.separatorInset = .zero
        view.addSubview(tableView)
        showHeaderRefresh(show: true) {
            
            self.getData()
        }
        tableView.mj_header.beginRefreshing()
    }
    
    fileprivate func getData() {
        
        provider.rx
            .request(.music_list(key: type!))
            .filterSuccessfulStatusCodes()
            .mapJSON()
            .subscribe(onSuccess: { (response) in

                self.tableView.mj_header.endRefreshing()
                DLog(message: response)
        }) { (error) in

            self.tableView.mj_header.endRefreshing()

            DLog(message: error)
        }.disposed(by: dispose)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
