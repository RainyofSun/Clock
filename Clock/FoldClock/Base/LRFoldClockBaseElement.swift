//
//  LRFoldClockBaseElement.swift
//  Clock
//
//  Created by 苍蓝猛兽 on 2023/1/31.
//

import UIKit

class LRFoldClockBaseElement: UIView {

    // 动画进度
    open var _animateValue: CGFloat = .zero
    // 刷新工具
    private var _link: CADisplayLink?
    // 起始旋转角度
    private(set) var NextLabelStartValue: CGFloat = 0.01
    // 放置label的容器
    private(set) lazy var _timeContainer: UIView = UIView.init(frame: CGRect.zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadFoldClockElementViews()
        layoutFoldClockElementViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        deallocPrint()
    }
    
    // MARK: 子类覆写
    public func loadFoldClockElementViews() {
        _link = CADisplayLink(target: self, selector: #selector(updateAnimationFoldClockElement))
        
        _timeContainer.backgroundColor = UIColor.init(red: 46/255.0, green: 43/255.0, blue: 46/255.0, alpha: 1)
        self.addSubview(_timeContainer)
    }
    
    public func layoutFoldClockElementViews() {
        _timeContainer.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: 动画相关
    public func start() {
        _link?.add(to: RunLoop.main, forMode: RunLoop.Mode.common)
    }
    
    public func stop() {
        _link?.remove(from: RunLoop.main, forMode: RunLoop.Mode.common)
    }
    
    // 默认的起始角度
    public func nextTimeStartTransform() -> CATransform3D {
        var t: CATransform3D = CATransform3DIdentity
        t.m34 = CGFLOAT_MIN
        t = CATransform3DRotate(t, Double.pi * NextLabelStartValue, -1, 0, 0)
        return t
    }
    
    // MARK: 外部调用接口
    public func updateTime(time: Int, nextTime: Int) {
        self.start()
    }
    
    public func free() {
        _link?.invalidate()
        _link = nil
    }
}

// MARK: Timer
extension LRFoldClockBaseElement {
    @objc func updateAnimationFoldClockElement() {
    
    }
}
