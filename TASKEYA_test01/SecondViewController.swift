//
//  SecondViewController.swift
//  TASKEYA_test01
//
//  Created by 井上航 on 2016/02/21.
//  Copyright © 2016年 Wataru Inoue. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    var titleString: String! //タイトル
    var supDecDate: NSDate! //実行者決定期限
    var decDate: NSDate! // 実行期限
    var priceInt: Int! //依頼価格
    var reqRangeString: String! //依頼相手
    
    override func viewDidLoad() {
        print(String(titleString))
        print(String(supDecDate))
        print(String(decDate))
        print(String(priceInt))
        print(String(reqRangeString))
    }
    
}
