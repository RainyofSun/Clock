//
//  LRSecondDailClock.swift
//  Clock
//
//  Created by 苍蓝猛兽 on 2023/2/2.
//

import UIKit

class LRSecondDailClock: LRDailClockBase {
    
    override var animationMode: DailHandAnimationMode {
        didSet {
            if animationMode == .Smooth && _link == nil {
                _link = CADisplayLink(target: self, selector: #selector(updateDailAnimation))
                _link?.add(to: RunLoop.main, forMode: RunLoop.Mode.common)
            } else {
                free()
            }
        }
    }
    
    override var date: Date? {
        didSet {
            guard let _d = date, animationMode == .Spring else {
                return
            }
            
            dailHandSpringAnimation(time: _d)
        }
    }
    
    // 刷新工具
    private var _link: CADisplayLink?
    
    override func loadFoldClockViews() {
        super.loadFoldClockViews()
        dailImageView.addSubview(secondHandImageView)
        
        dailImageView.image = UIImage.init(named: "bg")
        hourHandImageView.layer.anchorPoint = CGPoint(x: 0.5, y: 0.932)
        hourHandImageView.image = UIImage.init(named: "h1")
        minuteHandImageView.layer.anchorPoint = CGPoint(x: 0.5, y: 0.953)
        minuteHandImageView.image = UIImage.init(named: "m1")
        secondHandImageView.layer.anchorPoint = CGPoint(x: 0.5, y: 0.843)
        secondHandImageView.backgroundColor = .red
        
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        if self.bounds == .zero || hourHandImageView.bounds != .zero ||
            minuteHandImageView.bounds != .zero || secondHandImageView.bounds != .zero {
            return
        }
        let _hourImgSize: CGSize = hourHandImageView.image?.size ?? .zero
        let _minImgSize: CGSize = minuteHandImageView.image?.size ?? .zero
        
        hourHandImageView.frame = CGRect.init(x: (self.width - _hourImgSize.width) * 0.5, y: self.width * 0.2 + 8, width: _hourImgSize.width, height: self.width * 0.3)
        minuteHandImageView.frame = CGRect.init(x: (self.width - _minImgSize.width) * 0.5, y: self.width * 0.1 + 8, width: _minImgSize.width, height: self.width * 0.4)
        secondHandImageView.frame = CGRect(x: (self.width - 2) * 0.5, y: self.width * 0.02, width: 2, height: self.width * 0.57)
    }
    
    override func free() {
        super.free()
        _link?.invalidate()
        _link?.remove(from: RunLoop.main, forMode: RunLoop.Mode.common)
        _link = nil
    }
}

// MARK: LinkTimer
extension LRSecondDailClock {
    @objc func updateDailAnimation() {
        self.dailHandSmoothAnimation(time: Date())
    }
}
