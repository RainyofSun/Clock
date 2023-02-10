//
//  LRDashCircleView.swift
//  Clock
//
//  Created by 苍蓝猛兽 on 2023/2/2.
//

import UIKit

class LRDashCircleView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        deallocPrint()
    }
    
    override func draw(_ rect: CGRect) {
        let ovalRect: CGRect = rect.insetBy(dx: 10, dy: 10)
        let scaleRadius = ovalRect.height * 0.5
        let milliScale = UIBezierPath.init(ovalIn: ovalRect)
        milliScale.lineWidth = 1
        milliScale.lineCapStyle = .round
        milliScale.lineJoinStyle = .round
        /*
         https://www.jianshu.com/p/62faf786871f
         向setLineDash方法传入的三个参数：
         第一个参数：存放虚线各段长度的浮点数组。按照 划线--间隔--划线--间隔--... 设置，并且在最后一个浮点数表示的虚线部分绘制完毕后，回到第一个数进行循环，直到虚线绘制完成。
         第二个参数：截取数组的个数。当此数小于数组实际个数时，相当于截取数组的前n个来使用，数组剩余元素完全无用。
         第三个参数：偏移量
         */
        let mLineDashArr: [CGFloat] = [3.0, scaleRadius*CGFloat(Double.pi/30) - 2,
                                       1.0, scaleRadius*CGFloat(Double.pi/30) - 1,
                                       1.0, scaleRadius*CGFloat(Double.pi/30) - 1,
                                       1.0, scaleRadius*CGFloat(Double.pi/30) - 1,
                                       1.0, scaleRadius*CGFloat(Double.pi/30) - 2]
        milliScale.setLineDash(mLineDashArr, count: 10, phase: 1.5)
        UIColor.black.setStroke()
        milliScale.stroke()

    }
}
