//
//  LRFoldClockImageItem.swift
//  Clock
//
//  Created by 苍蓝猛兽 on 2023/1/31.
//

import UIKit

class LRFoldClockImageItem: LRFoldClockBaseItem {

    override var time: Int? {
        didSet {
            if let _t = time {
                self.configLeftTimeImageView(time: _t/10)
                self.configRightTimeImageView(time: _t%10)
            }
        }
    }

    private lazy var _leftTimeImageView: LRFoldClockImageElement = {
        return LRFoldClockImageElement(frame: CGRect.zero)
    }()
    
    private lazy var _rightTimeImageView: LRFoldClockImageElement = {
        return LRFoldClockImageElement(frame: CGRect.zero)
    }()
    
    override func loadFoldClockItemViews() {
        super.loadFoldClockItemViews()
        self.addSubview(_leftTimeImageView)
        self.addSubview(_rightTimeImageView)
    }
    
    override func layoutFoldClockItemViews() {
        super.layoutFoldClockItemViews()
        
        self._leftTimeImageView.snp.makeConstraints { make in
            make.left.verticalEdges.equalToSuperview()
        }
        
        self._rightTimeImageView.snp.makeConstraints { make in
            make.right.verticalEdges.equalToSuperview()
            make.left.equalTo(_leftTimeImageView.snp.right)
            make.width.equalTo(_leftTimeImageView)
        }
    }
    
    override func free() {
        super.free()
        _leftTimeImageView.free()
        _rightTimeImageView.free()
    }
}

private extension LRFoldClockImageItem {
    func configLeftTimeImageView(time: Int) {
        if _lastLeftTime == time && _lastLeftTime != initialValue {
            return
        }
        _lastLeftTime = time
        var _current: Int = .zero
        switch self.itemType {
        case .Hour:
            _current = time == .zero ? 2 : (time - 1)
        case .Minute:
            _current = time == .zero ? 5 : (time - 1)
        case .Second:
            _current = time == .zero ? 5 : (time - 1)
        case .none:
            break
        }
        _leftTimeImageView.updateTime(time: _current, nextTime: time)
    }
    
    func configRightTimeImageView(time: Int) {
        if _lastRightTime == time && _lastRightTime != initialValue {
            return
        }
        _lastRightTime = time
        var _current: Int = .zero
        switch self.itemType {
        case .Hour:
            _current = time == .zero ? 4 : (time - 1)
        case .Minute:
            _current = time == .zero ? 9 : (time - 1)
        case .Second:
            _current = time == .zero ? 9 : (time - 1)
        default:
            break
        }
        _rightTimeImageView.updateTime(time: _current, nextTime: time)
    }
}
