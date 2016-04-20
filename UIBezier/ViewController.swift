//
//  ViewController.swift
//  UIBezier
//
//  Created by 薛焱 on 16/3/18.
//  Copyright © 2016年 薛焱. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var shapeLayer = CAShapeLayer()
    override func viewDidLoad() {
        super.viewDidLoad()
        //创建一个PathView
        let pathView = PathView()
        pathView.frame = CGRect(x: 50, y: 0, width: 350, height: 550)
        view.addSubview(pathView)
        //实际上设置CAShapeLayer也可以实现同样的效果,这个就不写了,示例在另一个叫CAShapLayer的Demo里写过了
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

