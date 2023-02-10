//
//  LRClockOperationView.swift
//  Clock
//
//  Created by 苍蓝猛兽 on 2023/2/1.
//

import UIKit

class LRClockOperationView: LRClockOperationBaseView {
    
    private lazy var dotButton: UIButton = {
        let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.setImage(UIImage.init(named: "btn-blink"), for: UIControl.State.normal)
        btn.setImage(UIImage.init(named: "btn-blink"), for: UIControl.State.highlighted)
        return btn
    }()
    
    override func loadClockOperationViews() {
        super.loadClockOperationViews()
        self.addSubview(dotButton)
    }
    
    override func layoutClockOperationViews() {
        super.layoutClockOperationViews()
        dotButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.size.equalTo(alarmClockButton)
        }
    }
}

// MARK: Target
private extension LRClockOperationView {
    
    @objc func clickDotButton(sender: UIButton) {
        sender.isSelected = !sender.isSelected
        self.operationDelegate?.clock_showOrHideClockDot(isShow: sender.isSelected)
    }
}
