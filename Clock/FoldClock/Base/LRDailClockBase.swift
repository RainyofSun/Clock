//
//  LRDailClockBase.swift
//  Clock
//
//  Created by 苍蓝猛兽 on 2023/2/2.
//

import UIKit

class LRDailClockBase: LRFoldClockBase {
    
    /// 动画类型 默认顺滑类型
    open var animationMode: DailHandAnimationMode = .Smooth
    /// 是否显示秒点 默认不显示
    open var showSecondDash: Bool = false {
        didSet {
            showSecondDash ? buildSecondDashView() : removeSecondDashView()
        }
    }
    
    /// 表盘
    private(set) var dailImageView: UIImageView = {
        let view = UIImageView.init(frame: CGRect.zero)
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    /// 时针
    private(set) var hourHandImageView: UIImageView = {
        let view = UIImageView.init(frame: CGRect.zero)
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    /// 分针
    private(set) var minuteHandImageView: UIImageView = {
        let view = UIImageView.init(frame: CGRect.zero)
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    /// 秒针
    private(set) var secondHandImageView: UIImageView = {
        let view = UIImageView.init(frame: CGRect.zero)
        view.contentMode = .scaleToFill
        return view
    }()
    
    /// 秒点
    private var secondDashView: LRDashCircleView?
    
    override func loadFoldClockViews() {
        super.loadFoldClockViews()
        self.addSubview(dailImageView)
        dailImageView.addSubview(hourHandImageView)
        dailImageView.addSubview(minuteHandImageView)
    }
    
    override func layoutFoldClockViews() {
        super.layoutFoldClockViews()
        dailImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: Public Methods
    public func dailHandSpringAnimation(time: Date) {
        let dateComponents: DateComponents = Calendar.current.dateComponents([.hour, .minute, .second, .nanosecond], from: time)
        
        // 根据当前秒、分、时数分别计算秒针、分针、时针偏转弧度
        let secondAngle = CGFloat(Double(dateComponents.second!) * (Double.pi * 2.0 / 60))
        if secondHandImageView.superview != nil {
            secondHandImageView.transform = CGAffineTransform(rotationAngle: secondAngle)
        }
        
        let minuteAngle = CGFloat(Double(dateComponents.minute!) * (Double.pi * 2.0 / 60)) + secondAngle/60
        minuteHandImageView.transform = CGAffineTransform(rotationAngle: minuteAngle)
        
        let hourAngle = CGFloat(Double(dateComponents.hour!) * (Double.pi * 2.0 / 12)) + minuteAngle/12.0 + secondAngle/3600
        hourHandImageView.transform = CGAffineTransform(rotationAngle: hourAngle)
    }
    
    public func dailHandSmoothAnimation(time: Date) {
        let dateComponents: DateComponents = Calendar.current.dateComponents([.hour, .minute, .second, .nanosecond], from: time)
        // 秒针角度
        let secondAngle: CGFloat = (2.0 * Double.pi / 60) / 1000000000
        // 分针角度
        let minuteAngle: CGFloat = 2.0 * Double.pi / 60
        // 时针角度
        let hourAngle: CGFloat = 2.0 * Double.pi / 12
        
        let _ms: Int = dateComponents.nanosecond ?? 0
        let _s: Int = dateComponents.second ?? 0
        let _min: Int = dateComponents.minute ?? 0
        let _hour: Int = dateComponents.hour ?? 0
        
        if secondHandImageView.superview != nil {
            secondHandImageView.layer.setAffineTransform(CGAffineTransformMakeRotation(minuteAngle * CGFloat(_s) + secondAngle * CGFloat(_ms)))
        }
        
        minuteHandImageView.layer.setAffineTransform(CGAffineTransformMakeRotation((minuteAngle * CGFloat(_min) + minuteAngle * CGFloat(_s) / 60 + secondAngle * CGFloat(_ms) / 60)))
        hourHandImageView.layer.setAffineTransform(CGAffineTransformMakeRotation(hourAngle * CGFloat(_hour) + minuteAngle * CGFloat(_min)/12.0  + secondAngle * CGFloat(_s)/3600 + secondAngle * CGFloat(_ms)/3600))
    }
}

// MARK: Private Methods
private extension LRDailClockBase {
    func buildSecondDashView() {
        secondDashView = LRDashCircleView(frame: dailImageView.bounds)
        dailImageView.addSubview(secondDashView!)
    }
    
    func removeSecondDashView() {
        UIView.animate(withDuration: ImplicitAnimationTime) {
            self.secondDashView?.alpha = 0
        } completion: { _ in
            self.secondDashView?.removeFromSuperview()
            self.secondDashView = nil
        }
    }
}
