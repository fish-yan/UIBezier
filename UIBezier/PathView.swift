//
//  PathView.swift
//  UIBezier
//
//  Created by 薛焱 on 16/3/18.
//  Copyright © 2016年 薛焱. All rights reserved.
//

import UIKit

class PathView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.whiteColor()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //1.
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        UIColor.redColor().set()//设置颜色
//MARK: - 一次贝塞尔曲线
        //创建矩形
        creatRectanglePath()
        //创建圆,或者椭圆(rect为正方形时就是圆)
        creatOvalPath()
        //创建圆弧
        creatArcPath()
        //创建自定义图形(以五边形为例)
        creatPentagonPath()
//MARK: - 二次贝塞尔曲线
        creatQuadCurvePath()
//MARK: - 三次贝塞尔曲线
        creatCurvePath()
//MARK: - Core Graphics函数修改CGPath
        //单一修改CGPath
        creatSingleCGPath()
        //CGPath与UIBezierPath混合使用
        creatMixCGPathAndUIBezierPath()
        //内容控制(附加)
        setUpContext()
    }
    func creatPentagonPath() {
        
        let path = UIBezierPath()
        path.lineWidth = 2.0 //线宽
        //设置起点
        path.moveToPoint(CGPoint(x: 70.0, y: 20.0))
        //设置拐角点
        path.addLineToPoint(CGPoint(x: 120.0, y: 40.0))
        path.addLineToPoint(CGPoint(x: 100.0, y: 90.0))
        path.addLineToPoint(CGPoint(x: 40.0, y: 90.0))
        path.addLineToPoint(CGPoint(x: 20.0, y: 40.0))
        //最后闭合
        path.closePath()
        path.stroke()//描边样式
        //path.fill()//填充样式
    }

    
    func creatRectanglePath() {
        //创建bezier路径
        let path = UIBezierPath(rect: CGRect(x: 220, y: 30, width: 100, height: 50))
        path.lineCapStyle = .Round //拐角
        path.lineJoinStyle = .Miter //终点
        path.lineWidth = 2.0//设置线宽
        path.stroke()//描边样式
        //path.fill()//填充样式
    }
    
    func creatOvalPath() {
        //画出来的椭圆为ovalInRect画出的矩形的内切椭圆
        let path = UIBezierPath(ovalInRect: CGRect(x: 20, y: 120, width: 100, height: 50))
        path.lineWidth = 2
        path.fill()
    }
    
    func creatArcPath() {
        //其中的参数分别指定：这段圆弧的中心，半径，开始角度，结束角度，是否顺时针方向。
        let path = UIBezierPath(arcCenter: CGPoint(x: 270, y: 120), radius: 50, startAngle: 0, endAngle: CGFloat(M_PI), clockwise: true)
        path.lineWidth = 2
        path.stroke()
    }
    
    
    
    func creatQuadCurvePath() {
        let path = UIBezierPath()
        //设置起点
        path.moveToPoint(CGPoint(x: 20, y: 210))
        //参数分别指终点,中间控制点
        path.addQuadCurveToPoint(CGPoint(x: 120, y: 210), controlPoint: CGPoint(x: 70, y: 180))
        //添加圆弧, 参数依次为中心点, 半径, 开始角度, 结束角度, 是否顺时针
        path.addArcWithCenter(CGPoint(x: 70, y: 210), radius: 50, startAngle: 0.0, endAngle: CGFloat(M_PI), clockwise: true)
        path.lineWidth = 2
        path.stroke()
    }
    
    func creatCurvePath() {
        let path = UIBezierPath()
        //起点
        path.moveToPoint(CGPoint(x: 220, y: 230))
        //参数分别指终点,中间控制点
        path.addCurveToPoint(CGPoint(x: 320, y: 220), controlPoint1: CGPoint(x: 250, y: 200), controlPoint2: CGPoint(x: 290, y: 250))
        path.lineWidth = 2
        path.stroke()
    }
    
    func creatSingleCGPath() {
        //创建可变CGPath
        let cgPath = CGPathCreateMutable()
        CGPathAddEllipseInRect(cgPath, nil, CGRect(x: 20, y: 270, width: 100, height: 50))
        CGPathAddEllipseInRect(cgPath, nil, CGRect(x: 45, y: 282.5, width: 50, height: 25))
        let path = UIBezierPath()
        path.CGPath = cgPath
        path.usesEvenOddFillRule = true
        path.lineWidth = 2
        path.stroke()
//        CGPathRelease(cgPath);如果是OC需要执行这句代码
    }
    func creatMixCGPathAndUIBezierPath() {
        //创建贝塞尔曲线
        let path = UIBezierPath(ovalInRect: CGRect(x: 220, y: 270, width: 100, height: 50))
        //获取CGPath
        let cgPath = path.CGPath
        //copy给可变CGPath
        let mutablePath = CGPathCreateMutableCopy(cgPath)! as CGMutablePathRef
        //设置起点
        CGPathMoveToPoint(mutablePath, nil, 245, 295)
        //添加曲线
        //参数cp1x实际上是controlPoint1.x的缩写,所以参数为,控制点1,控制点2,终点
        CGPathAddCurveToPoint(mutablePath, nil, 255, 270, 285, 320, 295, 295)
        //其他函数
        /*
        //添加直线
        CGPathAddLineToPoint(<#T##path: CGMutablePath?##CGMutablePath?#>, <#T##m: UnsafePointer<CGAffineTransform>##UnsafePointer<CGAffineTransform>#>, <#T##x: CGFloat##CGFloat#>, <#T##y: CGFloat##CGFloat#>)
        //参数1,点的数组,参数2:count要绘制的点的个数
        CGPathAddLines(<#T##path: CGMutablePath?##CGMutablePath?#>, <#T##m: UnsafePointer<CGAffineTransform>##UnsafePointer<CGAffineTransform>#>, <#T##points: UnsafePointer<CGPoint>##UnsafePointer<CGPoint>#>, <#T##count: Int##Int#>)
        //添加路径
        CGPathAddPath(<#T##path1: CGMutablePath?##CGMutablePath?#>, <#T##m: UnsafePointer<CGAffineTransform>##UnsafePointer<CGAffineTransform>#>, <#T##path2: CGPath?##CGPath?#>)
        //添加二次路径
        CGPathAddQuadCurveToPoint(<#T##path: CGMutablePath?##CGMutablePath?#>, <#T##m: UnsafePointer<CGAffineTransform>##UnsafePointer<CGAffineTransform>#>, <#T##cpx: CGFloat##CGFloat#>, <#T##cpy: CGFloat##CGFloat#>, <#T##x: CGFloat##CGFloat#>, <#T##y: CGFloat##CGFloat#>)
        //添加矩形
        CGPathAddRect(<#T##path: CGMutablePath?##CGMutablePath?#>, <#T##m: UnsafePointer<CGAffineTransform>##UnsafePointer<CGAffineTransform>#>, <#T##rect: CGRect##CGRect#>)
        CGPathAddRects(<#T##path: CGMutablePath?##CGMutablePath?#>, <#T##m: UnsafePointer<CGAffineTransform>##UnsafePointer<CGAffineTransform>#>, <#T##rects: UnsafePointer<CGRect>##UnsafePointer<CGRect>#>, <#T##count: Int##Int#>)
        CGPathAddRoundedRect(<#T##path: CGMutablePath?##CGMutablePath?#>, <#T##transform: UnsafePointer<CGAffineTransform>##UnsafePointer<CGAffineTransform>#>, <#T##rect: CGRect##CGRect#>, <#T##cornerWidth: CGFloat##CGFloat#>, <#T##cornerHeight: CGFloat##CGFloat#>)
        //添加圆弧
        CGPathAddArc(<#T##path: CGMutablePath?##CGMutablePath?#>, <#T##m: UnsafePointer<CGAffineTransform>##UnsafePointer<CGAffineTransform>#>, <#T##x: CGFloat##CGFloat#>, <#T##y: CGFloat##CGFloat#>, <#T##radius: CGFloat##CGFloat#>, <#T##startAngle: CGFloat##CGFloat#>, <#T##endAngle: CGFloat##CGFloat#>, <#T##clockwise: Bool##Bool#>)
        CGPathAddRelativeArc(<#T##path: CGMutablePath?##CGMutablePath?#>, <#T##matrix: UnsafePointer<CGAffineTransform>##UnsafePointer<CGAffineTransform>#>, <#T##x: CGFloat##CGFloat#>, <#T##y: CGFloat##CGFloat#>, <#T##radius: CGFloat##CGFloat#>, <#T##startAngle: CGFloat##CGFloat#>, <#T##delta: CGFloat##CGFloat#>)
        */
        
        path.CGPath = mutablePath
        path.lineWidth = 2
        path.stroke()
    }
    
    func setUpContext() {
        let path = UIBezierPath(ovalInRect: CGRect(x: 20, y: 350, width: 100, height: 50))
        UIColor.redColor().setStroke()
        UIColor.orangeColor().setFill()
        let ref = UIGraphicsGetCurrentContext()
        //内容平移
        CGContextTranslateCTM(ref, 20, 20)
        //内容旋转
        //因为我把所有图形画在同一个视图中,anchorPoint并非当前椭圆的中心, 所以旋转后当前椭圆会偏离所在位置
        CGContextRotateCTM(ref, CGFloat(-M_PI_4/4));
        //内容缩放
        CGContextScaleCTM(ref, 0.8, 1.0)
        path.lineWidth = 2
        path.fill()
        path.stroke()
        
    }
}
