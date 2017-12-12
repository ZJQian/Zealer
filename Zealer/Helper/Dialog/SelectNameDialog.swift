//
//  SelectNameDialog.swift
//  Zealer
//
//  Created by ZJQian on 2017/12/8.
//  Copyright © 2017年 zjq. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

typealias HideCallBack = () -> Void

private let dispose = DisposeBag()

protocol SelectNameDialogDelegate {
    func selectName(dialog: SelectNameDialog, name: String)
}

class SelectNameDialog: UIView {

    var hideCallBack: HideCallBack?
    var delegate: SelectNameDialogDelegate?
    
    
    fileprivate var v_bg = UIView()
    fileprivate var v_warn = UIView()
    fileprivate let nameArray = ["朴树","李志","许巍","新裤子","窦唯","张楚","崔健","万青","郑钧","谢天笑","幼稚园杀手"]

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        superview?.addSubview(self)
        
        
        v_bg.frame = self.bounds
        v_bg.backgroundColor = rgba(red: 255.0, green: 255.0, blue: 255.0, alpha: 0.5)
        v_bg.alpha = 0
        v_bg.isUserInteractionEnabled = true
        addSubview(v_bg)
        
        let tap_gesture = UITapGestureRecognizer()
        v_bg.addGestureRecognizer(tap_gesture)
        tap_gesture.rx.event.subscribe { (tap) in
            
            self.hide()
        }.disposed(by: dispose)
        
        
        let row = nameArray.count%4
        let row2 = nameArray.count/4
        let h_collect = row == 0 ? (30+10)*(row2+1)+30 : (30+10)*(row2+1)+30
    
        v_warn.frame = CGRect.init(x: 0, y: CGFloat(-h_collect), width: frame.size.width, height: CGFloat(h_collect))
        v_warn.backgroundColor = UIColor.clear
        addSubview(v_warn)
        
        let layout = UICollectionViewFlowLayout()
        let w = (SCREEN_WIDTH-50)/4
        let h = 30
        layout.itemSize = CGSize.init(width: w, height: CGFloat(h))
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        
        let collect = UICollectionView.init(frame: v_warn.bounds, collectionViewLayout: layout)
        collect.delegate = self as UICollectionViewDelegate
        collect.dataSource = self as UICollectionViewDataSource
        collect.backgroundColor = UIColor.white
        v_warn.addSubview(collect)
        collect.register(SigerNameCell.self, forCellWithReuseIdentifier: "singerNameCell")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func show() {
        

        UIView.animate(withDuration: 0.5) {
            self.v_bg.alpha = 1
            var rect = self.v_warn.frame
            rect.origin.y += rect.size.height
            self.v_warn.frame = rect
        }
    }
    
    func hide() {
        
        UIView.animate(withDuration: 0.5, animations: {
            
            var rect = self.v_warn.frame
            rect.origin.y -= rect.size.height
            self.v_warn.frame = rect
            self.v_bg.alpha = 0
        }) { (finish) in
            
            if (self.hideCallBack != nil) {
                self.hideCallBack!()
            }
            self.removeFromSuperview()
        }
    }
}
extension SelectNameDialog: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nameArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "singerNameCell", for: indexPath) as! SigerNameCell
        cell.lb_singer.text = nameArray[indexPath.item]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        hide()
        self.delegate?.selectName(dialog: self, name: nameArray[indexPath.item])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 15, left: 10, bottom: 0, right: 10)
    }
}

class SigerNameCell: UICollectionViewCell {
    
    var lb_singer = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        lb_singer.frame = contentView.bounds
        lb_singer.textAlignment = .center
        lb_singer.font = UIFont.systemFont(ofSize: 12.0)
        lb_singer.setRadius(radius: lb_singer.height/2)
        lb_singer.layer.borderColor = NAVI_COLOR.cgColor
        lb_singer.layer.borderWidth = 1.0
        contentView.addSubview(lb_singer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
