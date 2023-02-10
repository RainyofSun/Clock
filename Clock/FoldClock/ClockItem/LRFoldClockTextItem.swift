//
//  LRFoldClockTextItem.swift
//  Clock
//
//  Created by 苍蓝猛兽 on 2023/1/31.
//

import UIKit

class LRFoldClockTextItem: LRFoldClockBaseItem {
    
    open var font: UIFont? {
        didSet {
            if let _f = font {
                self._leftTextLabel.font = _f
                self._rightTextLabel.font = _f
            }
        }
    }
    
    open var textColor: UIColor? {
        didSet {
            if let _c = textColor {
                self._leftTextLabel.textColor = _c
                self._rightTextLabel.textColor = _c
            }
        }
    }
    
    override var time: Int? {
        didSet {
            if let _t = time {
                self.configLeftTimeLabel(time: _t/10)
                self.configRightTimeLabel(time: _t%10)
            }
        }
    }
    
    private lazy var _leftTextLabel: LRFoldClockTextElement = {
        return LRFoldClockTextElement(frame: CGRect.zero)
    }()

    private lazy var _rightTextLabel: LRFoldClockTextElement = {
        return LRFoldClockTextElement(frame: CGRect.zero)
    }()
    
    private lazy var _lineView: UIView = {
        let view = UIView(frame: CGRect.zero)
        view.backgroundColor = .black
        return view
    }()

    override func loadFoldClockItemViews() {
        super.loadFoldClockItemViews()
        
        self.addSubview(_leftTextLabel)
        self.addSubview(_rightTextLabel)
        self.addSubview(_lineView)
    }
    
    override func layoutFoldClockItemViews() {
        super.layoutFoldClockItemViews()
        
        self._leftTextLabel.snp.makeConstraints { make in
            make.left.verticalEdges.equalToSuperview()
        }
        
        self._rightTextLabel.snp.makeConstraints { make in
            make.right.verticalEdges.equalToSuperview()
            make.left.equalTo(_leftTextLabel.snp.right)
            make.width.equalTo(_leftTextLabel)
        }
        
        self._lineView.snp.makeConstraints { make in
            make.center.width.equalToSuperview()
            make.height.equalTo(5)
        }
    }
    
    override func free() {
        super.free()
        _leftTextLabel.free()
        _rightTextLabel.free()
    }
    
    // MARK: Public Methods
    public func showDot() {
        _leftTextLabel._timeContainer.backgroundColor = .clear
        _rightTextLabel._timeContainer.backgroundColor = .clear
    }
    
    public func hideDot() {
        _leftTextLabel._timeContainer.backgroundColor = UIColor.init(red: 46/255.0, green: 43/255.0, blue: 46/255.0, alpha: 1)
        _rightTextLabel._timeContainer.backgroundColor = UIColor.init(red: 46/255.0, green: 43/255.0, blue: 46/255.0, alpha: 1)
    }
}

private extension LRFoldClockTextItem {
    func configLeftTimeLabel(time: Int) {
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
        _leftTextLabel.updateTime(time: _current, nextTime: time)
    }
    
    func configRightTimeLabel(time: Int) {
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
        _rightTextLabel.updateTime(time: _current, nextTime: time)
    }
}
