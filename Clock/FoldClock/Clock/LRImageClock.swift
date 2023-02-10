//
//  LRImageClock.swift
//  Clock
//
//  Created by 苍蓝猛兽 on 2023/2/1.
//

import UIKit

class LRImageClock: LRFoldClockBase {

    override var date: Date? {
        didSet {
            guard let _d = date else {
                return
            }
            let dateComponents: DateComponents = Calendar.current.dateComponents([.hour,.minute,.second], from: _d)
            _hourItem.time = dateComponents.hour
            _minuteItem.time = dateComponents.minute
            _secondItem.time = dateComponents.second
        }
    }

    private lazy var _hourItem: LRFoldClockImageItem = {
        return LRFoldClockImageItem(frame: CGRect.zero)
    }()
    
    private lazy var _minuteItem: LRFoldClockImageItem = {
        return LRFoldClockImageItem(frame: CGRect.zero)
    }()
    
    private lazy var _secondItem: LRFoldClockImageItem = {
        return LRFoldClockImageItem(frame: CGRect.zero)
    }()
    
    override func loadFoldClockViews() {
        super.loadFoldClockViews()
        _hourItem.itemType = .Hour
        _minuteItem.itemType = .Minute
        _secondItem.itemType = .Second
        
        self.addSubview(_hourItem)
        self.addSubview(_minuteItem)
        self.addSubview(_secondItem)
    }
    
    override func layoutFoldClockViews() {
        super.layoutFoldClockViews()
        _hourItem.snp.makeConstraints { make in
            make.verticalEdges.left.equalToSuperview()
        }
        
        _minuteItem.snp.makeConstraints { make in
            make.left.equalTo(_hourItem.snp.right).offset(space)
            make.verticalEdges.equalToSuperview()
            make.width.equalTo(_hourItem)
        }
        
        _secondItem.snp.makeConstraints { make in
            make.left.equalTo(_minuteItem.snp.right).offset(space)
            make.right.verticalEdges.equalToSuperview()
            make.width.equalTo(_minuteItem)
        }
    }
    
    override func free() {
        super.free()
        _hourItem.free()
        _minuteItem.free()
        _secondItem.free()
    }
}
