//
//  LRFoldClockBaseItem.swift
//  Clock
//
//  Created by 苍蓝猛兽 on 2023/1/31.
//

import UIKit

class LRFoldClockBaseItem: UIView {

    enum FoldClockItemType: Int {
        case Hour
        case Minute
        case Second
    }
    
    open var itemType: FoldClockItemType?
    open var time: Int?
        
    private(set) var initialValue: Int = -1
    var _lastLeftTime: Int = 0
    var _lastRightTime: Int = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadFoldClockItemViews()
        layoutFoldClockItemViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        deallocPrint()
    }
    
    // MARK: 子类覆写
    public func loadFoldClockItemViews() {
        self.layer.cornerRadius = 8
        self.clipsToBounds = true
        
        _lastLeftTime = initialValue
        _lastRightTime = initialValue
    }
    
    public func layoutFoldClockItemViews() {
        
    }
    
    public func free() {
        
    }
}
