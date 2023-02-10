//
//  LRTextClock.swift
//  Clock
//
//  Created by 苍蓝猛兽 on 2023/2/1.
//

import UIKit

class LRTextClock: LRFoldClockBase {

    open var font: UIFont? {
        didSet {
            _hourItem.font = font
            _minuteItem.font = font
            _secondItem.font = font
        }
    }
    
    open var textColor: UIColor? {
        didSet {
            _hourItem.textColor = textColor
            _minuteItem.textColor = textColor
            _secondItem.textColor = textColor
        }
    }
    
    /// 是否显示点 默认不显示
    open var showDot: Bool? {
        didSet {
            if let _s = showDot {
                _s ? _hourItem.showDot() : _hourItem.hideDot()
                _s ? _minuteItem.showDot() : _minuteItem.hideDot()
                _s ? _secondItem.showDot() : _secondItem.hideDot()
                _s ? buildDotView() : removeDotView()
            }
        }
    }
    
    override var date: Date? {
        didSet {
            guard let _d = date else {
                return
            }
            let dateComponents: DateComponents = Calendar.current.dateComponents([.hour, .minute, .second], from: _d)
            _hourItem.time = dateComponents.hour
            _minuteItem.time = dateComponents.minute
            _secondItem.time = dateComponents.second
        }
    }
    
    private lazy var _hourItem: LRFoldClockTextItem = {
        return LRFoldClockTextItem(frame: CGRect.zero)
    }()
    
    private lazy var _minuteItem: LRFoldClockTextItem = {
        return LRFoldClockTextItem(frame: CGRect.zero)
    }()
    
    private lazy var _secondItem: LRFoldClockTextItem = {
        return LRFoldClockTextItem(frame: CGRect.zero)
    }()
    
    private var _hourDotView: LRClockDotView?
    private var _minuteDotView: LRClockDotView?
    
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
    
    override func updateClockConstraints() {
        super.updateClockConstraints()
        _minuteItem.snp.updateConstraints { make in
            make.left.equalTo(_hourItem.snp.right).offset(space)
        }
        
        _secondItem.snp.updateConstraints { make in
            make.left.equalTo(_minuteItem.snp.right).offset(space)
        }
    }
    
    override func free() {
        super.free()
        _minuteItem.free()
        _secondItem.free()
        _hourItem.free()
    }
}

private extension LRTextClock {
    func buildDotView() {
        _hourDotView = LRClockDotView(frame: CGRect.zero)
        _minuteDotView = LRClockDotView(frame: CGRect.zero)
        self.addSubview(_hourDotView!)
        self.addSubview(_minuteDotView!)
        
        _hourDotView?.snp.makeConstraints({ make in
            make.verticalEdges.equalTo(_hourItem)
            make.left.equalTo(_hourItem.snp.right)
            make.right.equalTo(_minuteItem.snp.left)
        })
        
        _minuteDotView?.snp.makeConstraints { make in
            make.verticalEdges.equalTo(_minuteItem)
            make.left.equalTo(_minuteItem.snp.right)
            make.right.equalTo(_secondItem.snp.left)
        }
    }
    
    func removeDotView() {
        UIView.animate(withDuration: ImplicitAnimationTime) {
            self._hourDotView?.alpha = 0
            self._minuteDotView?.alpha = 0
        } completion: { _ in
            self._hourDotView?.removeFromSuperview()
            self._minuteDotView?.removeFromSuperview()
            self._hourDotView = nil
            self._minuteDotView = nil
        }
    }
}
