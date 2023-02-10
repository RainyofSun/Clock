//
//  LRClockViewController.swift
//  Clock
//
//  Created by 苍蓝猛兽 on 2023/2/1.
//

import UIKit
import SnapKit

class LRClockViewController: UIViewController {

    private lazy var _textClock: LRTextClock = {
        return LRTextClock(frame: CGRect.zero, clockType: ClockType.LocalClock, clockExterior: ClockExterior.BlackAndWhiteText)
    }()
    
    private lazy var _imageClock: LRImageClock = {
        return LRImageClock(frame: CGRect.zero, clockType: ClockType.LocalClock, clockExterior: ClockExterior.BlackAndWhiteText)
    }()
    
    private lazy var _dailClock: LRDailClock = {
        return LRDailClock(frame: CGRect.zero, clockType: ClockType.LocalClock, clockExterior: ClockExterior.Dial)
    }()
    
    private lazy var _secondDailClock: LRSecondDailClock = {
        return LRSecondDailClock(frame: CGRect.zero, clockType: ClockType.LocalClock, clockExterior: ClockExterior.SecondsDial)
    }()
    
    private var _controlView: LRClockControlView = {
        return LRClockControlView(frame: CGRect.zero)
    }()
    
    private lazy var _containScrollView: UIScrollView = {
        let view = UIScrollView(frame: CGRect.zero)
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.isPagingEnabled = true
        view.isScrollEnabled = false
        return view
    }()
    
    private var _benginPoint: CGPoint = .zero
    private var _clock: LRFoldClockBase?
    
    private let TimerID: String = "com.clock.timerQueue"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadClockViews()
        layoutClockViews()
        loadTimer()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate { context in
            if size.width > size.height {
                // 横屏
                if self._clock?._clockExterior == .Dial || self._clock?._clockExterior == .SecondsDial {
                    
                } else {
                    self._clock?.snp.remakeConstraints { make in
                        make.horizontalEdges.equalToSuperview().inset(size.width * 0.01)
                        make.centerY.equalToSuperview()
                        make.height.equalToSuperview().dividedBy(2)
                    }
                }
            } else {
                // 竖屏
                if self._clock?._clockExterior == .Dial || self._clock?._clockExterior == .SecondsDial {
                    
                } else {
                    self._clock?.snp.remakeConstraints { make in
                        make.horizontalEdges.equalToSuperview().inset(size.width * 0.01)
                        make.centerY.equalToSuperview()
                        make.height.equalToSuperview().dividedBy(4)
                    }
                }
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        for touch: AnyObject in touches {
            let t:UITouch = touch as! UITouch
            _benginPoint = t.location(in: self.view)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        var newPoint: CGPoint = .zero
        for touch: AnyObject in touches {
            let t: UITouch = touch as! UITouch
            newPoint = t.location(in: self.view)
        }
        let x_dis : CGFloat = CGFloat(abs(newPoint.x - _benginPoint.x))
        let y_dis: CGFloat = CGFloat(abs(newPoint.y - _benginPoint.y))
        if x_dis > y_dis {
        } else {
            var _brightness = UIScreen.main.brightness
            if newPoint.y < _benginPoint.y {
                // 竖直上滑动 ---- 屏幕亮度增加
                _brightness += (y_dis/ScreenHeight)
            } else {
                // 竖直下滑动 ---- 屏幕亮度减弱
                _brightness -= (y_dis/ScreenHeight)
            }
            UIScreen.main.brightness = max(min(_brightness, 1), 0)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        _benginPoint = .zero
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        _benginPoint = .zero
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

private extension LRClockViewController {
    func loadClockViews() {
        view.backgroundColor = .black
        
        _controlView.clockOperationDelegate = self
        _textClock.space = 15
        _secondDailClock.animationMode = .Spring
        _containScrollView.contentSize = CGSize(width: self.view.width * 4, height: self.view.height)
        self.view.addSubview(_containScrollView)
        _containScrollView.addSubview(_textClock)
        _containScrollView.addSubview(_imageClock)
        _containScrollView.addSubview(_dailClock)
        _containScrollView.addSubview(_secondDailClock)
        self._clock = _textClock
//        self.view.addSubview(_textClock)
//        self._clock = _textClock
//        self.view.addSubview(_imageClock)
//        self._clock = _imageClock
//        self.view.addSubview(_dailClock)
//        self._clock = _dailClock
//        self.view.addSubview(_secondDailClock)
//        self._clock = _secondDailClock
        self.view.addSubview(_controlView)
//        delay(5) {
//            self._secondDailClock.showSecondDash = true
//        }
    }
    
    func layoutClockViews() {
        
        self._containScrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        _textClock.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(self.view.width * 0.01)
            make.width.equalTo(self.view.width * 0.98)
            make.top.equalToSuperview().offset(self.view.height * 0.375)
            make.height.equalToSuperview().dividedBy(4)
        }

        _imageClock.snp.makeConstraints { make in
            make.left.equalTo(_textClock.snp.right).offset(self.view.width * 0.02)
            make.top.size.equalTo(_textClock)
        }

        _dailClock.snp.makeConstraints { make in
            make.left.equalTo(_imageClock.snp.right).offset(self.view.width * 0.02)
            make.top.equalToSuperview().offset(self.view.height * 0.5 - self.view.width * 0.49)
            make.size.equalTo(self.view.width * 0.98)
        }

        _secondDailClock.snp.makeConstraints { make in
            make.left.equalTo(_dailClock.snp.right).offset(self.view.width * 0.02)
            make.size.top.equalTo(_dailClock)
            make.right.equalToSuperview().offset(-self.view.width * 0.01)
        }
        
//        if _clock?._clockExterior == .Dial || _clock?._clockExterior == .SecondsDial {
//            _clock?.snp.makeConstraints({ make in
//                make.size.equalTo(self.view.width * 0.98)
//                make.center.equalToSuperview()
//            })
//        } else {
//            _clock?.snp.makeConstraints { make in
//                make.horizontalEdges.equalToSuperview().inset(self.view.width * 0.01)
//                make.centerY.equalToSuperview()
//                make.height.equalToSuperview().dividedBy(4)
//            }
//        }
        
        _controlView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func loadTimer() {
        // 开启定时器
        LRGCDTimerManager.scheduledTimer(name: TimerID, interval: 1) {[weak self] time in
            exchangeMainQueue {
//                self?._clock?.date = Date()
                let _date = Date()
                self?._textClock.date = _date
                self?._imageClock.date = _date
                self?._dailClock.date = _date
                self?._secondDailClock.date = _date
            }
        }
        LRGCDTimerManager.start(TimerID)
    }
}

// MARK: ClockOperationProtocol
extension LRClockViewController: ClockOperationProtocol {
    func clock_showWordClock() {
        
    }
    
    func clock_showClockSetting() {
        
    }
    
    func clock_switchLocalClockExterior(isLeft: Bool) {
        var contentOffSet: CGPoint = self._containScrollView.contentOffset
        if isLeft {
            if contentOffSet == .zero {
                contentOffSet = CGPoint(x: self.view.width * 3, y: 0)
                self._containScrollView.setContentOffset(contentOffSet, animated: false)
            } else {
                contentOffSet.x -= self.view.width
                self._containScrollView.setContentOffset(contentOffSet, animated: true)
            }
        } else {
            if contentOffSet.x == self.view.width * 3 {
                self._containScrollView.setContentOffset(CGPoint.zero, animated: false)
            } else {
                contentOffSet.x += self.view.width
                self._containScrollView.setContentOffset(contentOffSet, animated: true)
            }
        }
    }
    
    func clock_showAlarmClockSetting() {
        
    }
    
    func clock_showOrHideClockDot(isShow: Bool) {
        guard let _textClock = _clock as? LRTextClock else {
            return
        }
        _textClock.showDot = isShow
    }
    
    func clock_showClockHelping() {
        
    }
}
