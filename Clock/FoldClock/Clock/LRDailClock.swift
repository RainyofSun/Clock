//
//  LRDailClock.swift
//  Clock
//
//  Created by 苍蓝猛兽 on 2023/2/2.
//

import UIKit

class LRDailClock: LRDailClockBase {

    override var date: Date? {
        didSet {
            guard let _d = date else {
                return
            }
            
            let dateComponents: DateComponents = Calendar.current.dateComponents([.hour, .minute, .second], from: _d)
            // 根据当前秒、分、时数分别计算秒针、分针、时针偏转弧度
            let minuteAngle = CGFloat ( Double(dateComponents.minute!) * (Double.pi * 2.0 / 60) )
            minuteHandImageView.transform = CGAffineTransform(rotationAngle: minuteAngle)

            let hourAngle = CGFloat ( Double(dateComponents.hour!) * (Double.pi * 2.0 / 12) )
            hourHandImageView.transform = CGAffineTransform(rotationAngle: hourAngle)
        }
    }
    
    override func loadFoldClockViews() {
        super.loadFoldClockViews()
        dailImageView.image = UIImage.init(named: "bg")
        hourHandImageView.layer.anchorPoint = CGPoint(x: 0.5, y: 0.943)
        hourHandImageView.image = UIImage.init(named: "h1")
        minuteHandImageView.layer.anchorPoint = CGPoint(x: 0.5, y: 0.953)
        minuteHandImageView.image = UIImage.init(named: "m1")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        if self.bounds == .zero || hourHandImageView.bounds != .zero || minuteHandImageView.bounds != .zero {
            return
        }
        let _hourImgSize: CGSize = hourHandImageView.image?.size ?? .zero
        let _minImgSize: CGSize = minuteHandImageView.image?.size ?? .zero
        hourHandImageView.frame = CGRect.init(x: (self.width - _hourImgSize.width) * 0.5, y: self.width * 0.2 + 8, width: _hourImgSize.width, height: self.width * 0.3)
        minuteHandImageView.frame = CGRect.init(x: (self.width - _minImgSize.width) * 0.5, y: self.width * 0.1 + 8, width: _minImgSize.width, height: self.width * 0.4)
    }
}
