//
//  LRFoldClockTextElement.swift
//  Clock
//
//  Created by 苍蓝猛兽 on 2023/1/31.
//

import UIKit

class LRFoldClockTextElement: LRFoldClockBaseElement {

    open var font: UIFont? {
        didSet {
            if let _f = font {
                _timeLabel.font = _f
                _foldLabel.font = _f
                _nextLabel.font = _f
            }
        }
    }
    
    open var textColor: UIColor? {
        didSet {
            if let _c = textColor {
                _timeLabel.textColor = _c
                _foldLabel.textColor = _c
                _nextLabel.textColor = _c
            }
        }
    }
    
    // 当前时间label
    private lazy var _timeLabel: UILabel = UILabel.init(frame: CGRect.zero)
    // 反转动画label
    private lazy var _foldLabel: UILabel = UILabel.init(frame: CGRect.zero)
    // 下一个时间label
    private lazy var _nextLabel: UILabel = UILabel.init(frame: CGRect.zero)
    
    override func loadFoldClockElementViews() {
        super.loadFoldClockElementViews()
        
        configLable(label: _timeLabel)
        _timeContainer.addSubview(_timeLabel)
        
        configLable(label: _nextLabel)
        _nextLabel.isHidden = true
        // 设置显示角度,为了能够显示上半部分，下半部分隐藏
        _nextLabel.layer.transform = nextTimeStartTransform()
        _timeContainer.addSubview(_nextLabel)
        
        configLable(label: _foldLabel)
        _timeContainer.addSubview(_foldLabel)
    }
    
    override func layoutFoldClockElementViews() {
        super.layoutFoldClockElementViews()
        _timeLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        _nextLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        _foldLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func updateAnimationFoldClockElement() {
        super.updateAnimationFoldClockElement()
        _animateValue += 2/60.0
        if _animateValue >= 1 {
            self.stop()
            return
        }
        var t: CATransform3D = CATransform3DIdentity
        t.m34 = CGFLOAT_MIN
        // 绕X轴进行翻转
        t = CATransform3DRotate(t, Double.pi * _animateValue, -1, 0, 0)
        if _animateValue >= 0.5 {
            // 当反转到和屏幕垂直时,翻转Y和Z轴
            t = CATransform3DRotate(t, Double.pi, 0, 0, 1)
            t = CATransform3DRotate(t, Double.pi, 0, 1, 0)
        }
        
        _foldLabel.layer.transform = t
        // 当翻转到和屏幕垂直时,切换动画label的文字
        _foldLabel.text = _animateValue >= 0.5 ? _nextLabel.text : _timeLabel.text
        // 当翻转到指定角度时,显示下一秒的时间
        _nextLabel.isHidden = _animateValue <= NextLabelStartValue
    }
    
    // MARK: Public Methods
    override func updateTime(time: Int, nextTime: Int) {
        _timeLabel.text = String(time)
        _foldLabel.text = String(time)
        _nextLabel.text = String(nextTime)
        _nextLabel.layer.transform = nextTimeStartTransform()
        _nextLabel.isHidden = true
        _animateValue = .zero
        super.updateTime(time: time, nextTime: nextTime)
    }
}

private extension LRFoldClockTextElement {
    func configLable(label: UILabel) {
        label.textAlignment = .center
        label.textColor = UIColor.init(red: 186/255.0, green: 183/255.0, blue: 186/255.0, alpha: 1)
        label.font = UIFont.init(name: "AmericanTypewriter-Condensed", size: 130)
        label.clipsToBounds = true
        label.backgroundColor = .black
    }
}
