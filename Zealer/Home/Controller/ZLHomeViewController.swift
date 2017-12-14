//
//  ZLHomeViewController.swift
//  Zealer
//
//  Created by ZJQian on 2017/12/6.
//  Copyright © 2017年 zjq. All rights reserved.
//

import UIKit
import Moya
import RxSwift
import RxCocoa

private let dispose = DisposeBag()
class ZLHomeViewController: ZLBaseViewController {

    
    var seg: ZLHomeSegmentView?
    
    lazy var scrollView: UIScrollView = {
        let sv = UIScrollView.init(frame: view.bounds)
        sv.isPagingEnabled = true
        sv.showsHorizontalScrollIndicator = false
        return sv
    }()
    
    private let titleArray = ["正在热映","即将上映","Top250","北美票房榜"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        showBackItem(show: false)
        setNavi()
        setSubViews()
    }
    
    fileprivate func setNavi() {
                
        seg = ZLHomeSegmentView.init(frame: CGRect.init(x: 20, y: 0, width: SCREEN_WIDTH-80, height:44), titleArray: titleArray)
        seg?.delegate = self
        navigationItem.titleView = seg
        showRightItem(imageName: "search")
    }
    
    fileprivate func setSubViews() {
        
        navigationController?.delegate = self
        scrollView.delegate = self
        view.addSubview(scrollView)
        for _ in 0..<titleArray.count {
            let vc = HomeItemViewController()
            vc.delegate = self as HomeItemViewControllerDelegate
            addChildViewController(vc)
        }
        scrollView.contentSize = CGSize.init(width: SCREEN_WIDTH*CGFloat(titleArray.count), height: 0)
        scrollViewDidEndScrollingAnimation(scrollView)
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        
        let offset_x = scrollView.contentOffset.x
        let index: Int = Int(offset_x/SCREEN_WIDTH)
        let vc = childViewControllers[index] as! HomeItemViewController
        vc.api_type = [APIManager.in_theaters,
                       APIManager.coming_soon,
                       APIManager.top250,
                       APIManager.us_box][index]
        vc.index = index
        if vc.isViewLoaded {
            return
        }
        vc.view.frame = CGRect.init(x: offset_x, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT-49)
        scrollView.addSubview(vc.view)
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollViewDidEndScrollingAnimation(scrollView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ZLHomeViewController: ZLHomeSegmentViewDelegate,HomeItemViewControllerDelegate,UINavigationControllerDelegate {
    
    func clickSegment(withIndex index: Int) {
        scrollView.setContentOffset(CGPoint.init(x: CGFloat(index)*SCREEN_WIDTH, y: scrollView.contentOffset.y), animated: true)
    }
    
    func didSelectedItem(withIndex index: Int) {
        
        let vc = ItemDetailViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        
//        let isShow = viewController.isKind(of: ZLHomeViewController.self as AnyClass)
//        seg?.isHidden = !isShow
    }
    
}

