//
//  ViewController.swift
//  snapkitTest
//
//  Created by 3D on 16/11/30.
//  Copyright © 2016年 3D. All rights reserved.
//

import UIKit
import SnapKit
import Alamofire
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let vvview = UIView()
        self.view.addSubview(vvview)
        vvview.backgroundColor = UIColor.blue
        vvview.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.top.equalTo(10)
            make.right.equalTo(-10)
            make.height.equalTo(20)
            
            
        }
        
        let aaaview = UIView()
        self.view.addSubview(aaaview)
        aaaview.backgroundColor = UIColor.yellow
        aaaview.snp.makeConstraints { (aaa) in
            aaa.left.equalTo(vvview.snp.left).offset(10)
            aaa.top.equalTo(vvview.snp.bottom).offset(10)
            aaa.right.equalTo(vvview.snp.right).offset(-10)
            aaa.height.equalTo(20)
        }
        
        let lable = UILabel()
        lable.text = "测试label"
        lable.backgroundColor = UIColor.red
        self.view.addSubview(lable)
        lable.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.top.equalTo(aaaview.snp.bottom).offset(100)
        }
        
//        Alamofire.request("", method: .get, parameters: nibName, encoding: nil, headers: nibName)
        Alamofire.request(<#T##url: URLConvertible##URLConvertible#>, method: <#T##HTTPMethod#>, parameters: <#T##Parameters?#>, encoding: <#T##ParameterEncoding#>, headers: <#T##HTTPHeaders?#>)
        
        
    }
}

































