//
//  LRFoldClockBase.swift
//  Clock
//
//  Created by 苍蓝猛兽 on 2023/2/1.
//

import UIKit

class LRFoldClockBase: UIView {

    /// 时间
    open var date: Date?
    /// 时分秒间隙 默认屏幕宽度的 0.015 倍(即时钟点的大小)
    open var space: CGFloat = ScreenWidth * 0.015 {
        didSet {
            updateClockConstraints()
        }
    }
    /// 时钟外貌风格
    private(set) var _clockExterior: ClockExterior = .BlackAndWhiteText
    /// 时钟类型
    private(set) var _clockType: ClockType = .LocalClock
    
    init(frame: CGRect, clockType: ClockType, clockExterior: ClockExterior) {
        super.init(frame: frame)
        _clockType = clockType
        _clockExterior = clockExterior
        loadFoldClockViews()
        layoutFoldClockViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        deallocPrint()
    }
    
    override func removeFromSuperview() {
        super.removeFromSuperview()
        free()
    }

    // MARK: 子类覆写
    public func loadFoldClockViews() {
        self.backgroundColor = .clear
    }
    
    public func layoutFoldClockViews() {
        
    }
    
    public func updateClockConstraints() {
        
    }
    
    public func free() {
        
    }
}
