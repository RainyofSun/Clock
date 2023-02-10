//
//  LRClockOperationBaseView.swift
//  Clock
//
//  Created by 苍蓝猛兽 on 2023/2/2.
//

import UIKit

class LRClockOperationBaseView: UIView {

    /// 代理
    weak open var operationDelegate: ClockOperationProtocol?
    
    private lazy var wordClockButton: UIButton = {
        let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.setImage(UIImage.init(named: "btn-world"), for: UIControl.State.normal)
        btn.setImage(UIImage.init(named: "btn-world"), for: UIControl.State.highlighted)
        return btn
    }()
    
    private lazy var settingButton: UIButton = {
        let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.setImage(UIImage.init(named: "btn-option"), for: UIControl.State.normal)
        btn.setImage(UIImage.init(named: "btn-option"), for: UIControl.State.highlighted)
        return btn
    }()
    
    private lazy var leftButton: UIButton = {
        let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.setImage(UIImage.init(named: "btn-left"), for: UIControl.State.normal)
        btn.setImage(UIImage.init(named: "btn-left"), for: UIControl.State.highlighted)
        return btn
    }()
    
    private lazy var rightButton: UIButton = {
        let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.setImage(UIImage.init(named: "btn-right"), for: UIControl.State.normal)
        btn.setImage(UIImage.init(named: "btn-right"), for: UIControl.State.highlighted)
        return btn
    }()
    
    private(set) lazy var alarmClockButton: UIButton = {
        let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.setImage(UIImage.init(named: "btn-alarm"), for: UIControl.State.normal)
        btn.setImage(UIImage.init(named: "btn-alarm"), for: UIControl.State.highlighted)
        return btn
    }()
    
    private lazy var helpButton: UIButton = {
        let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.setImage(UIImage.init(named: "btn-help"), for: UIControl.State.normal)
        btn.setImage(UIImage.init(named: "btn-help"), for: UIControl.State.highlighted)
        return btn
    }()
    
    /// 延迟隐藏自己的时间
    private let _delayTime: TimeInterval = 3
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadClockOperationViews()
        layoutClockOperationViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        deallocPrint()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(delayHide), object: nil)
        self.perform(#selector(delayHide), with: nil, afterDelay: _delayTime)
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        delay(2) { [weak self] in
            self?.perform(#selector(self?.delayHide), with: nil, afterDelay: self?._delayTime ?? 1)
        }
    }
    
    override func removeFromSuperview() {
        super.removeFromSuperview()
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(delayHide), object: nil)
    }
    
    // MARK: 子类覆写
    func loadClockOperationViews() {
        
        wordClockButton.addTarget(self, action: #selector(clickWordButton(sender: )), for: UIControl.Event.touchUpInside)
        settingButton.addTarget(self, action: #selector(clickSettingBUtton(sender: )), for: UIControl.Event.touchUpInside)
        leftButton.addTarget(self, action: #selector(clickLeftButton(sender: )), for: UIControl.Event.touchUpInside)
        rightButton.addTarget(self, action: #selector(clickRightButton(sender: )), for: UIControl.Event.touchUpInside)
        alarmClockButton.addTarget(self, action: #selector(clickAlarmButton(sender: )), for: UIControl.Event.touchUpInside)
        helpButton.addTarget(self, action: #selector(clickHelpButton(sender: )), for: UIControl.Event.touchUpInside)
        
        self.addSubview(wordClockButton)
        self.addSubview(settingButton)
        self.addSubview(leftButton)
        self.addSubview(rightButton)
        self.addSubview(alarmClockButton)
        self.addSubview(helpButton)
    }
    
    func layoutClockOperationViews() {
        wordClockButton.snp.makeConstraints { make in
            make.left.top.equalToSuperview().offset(5)
            make.size.equalTo(40)
        }
        
        settingButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-5)
            make.size.equalTo(wordClockButton)
        }
        
        leftButton.snp.makeConstraints { make in
            make.size.left.equalTo(wordClockButton)
            make.centerY.equalToSuperview()
        }
        
        rightButton.snp.makeConstraints { make in
            make.size.right.equalTo(settingButton)
            make.centerY.equalToSuperview()
        }
        
        alarmClockButton.snp.makeConstraints { make in
            make.size.left.equalTo(wordClockButton)
            make.bottom.equalToSuperview().offset(-5)
        }
        
        helpButton.snp.makeConstraints { make in
            make.centerY.equalTo(alarmClockButton)
            make.size.right.equalTo(settingButton)
        }
    }
    
    // MARK: Public Methods
    /// 展示自己
    public func showOperation() {
        UIView.animate(withDuration: ImplicitAnimationTime) {
            self.alpha = 1
        } completion: { _ in
            self.perform(#selector(self.delayHide), with: nil, afterDelay: self._delayTime)
        }
    }
}

private extension LRClockOperationBaseView {
    // 延迟隐藏自己
    @objc func delayHide() {
        UIView.animate(withDuration: ImplicitAnimationTime) {
            self.alpha = 0
        }
    }
}

// MARK: Target
private extension LRClockOperationBaseView {
    @objc func clickWordButton(sender: UIButton) {
        self.operationDelegate?.clock_showWordClock()
    }
    
    @objc func clickSettingBUtton(sender: UIButton) {
        self.operationDelegate?.clock_showClockSetting()
    }
    
    @objc func clickLeftButton(sender: UIButton) {
        self.operationDelegate?.clock_switchLocalClockExterior(isLeft: true)
    }
    
    @objc func clickRightButton(sender: UIButton) {
        self.operationDelegate?.clock_switchLocalClockExterior(isLeft: false)
    }
    
    @objc func clickAlarmButton(sender: UIButton) {
        self.operationDelegate?.clock_showAlarmClockSetting()
    }
    
    @objc func clickHelpButton(sender: UIButton) {
        self.operationDelegate?.clock_showClockHelping()
    }
}
