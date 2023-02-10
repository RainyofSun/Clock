//
//  LRClockDotView.swift
//  Clock
//
//  Created by 苍蓝猛兽 on 2023/2/1.
//

import UIKit

class LRClockDotView: UIView {

    private lazy var _topDot: UIView = {
        let view = UIView.init(frame: CGRect.zero)
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var _bottomDot: UIView = {
        let view = UIView.init(frame: CGRect.zero)
        view.backgroundColor = .white
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(_topDot)
        self.addSubview(_bottomDot)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if self.bounds == .zero {
            return
        }
        
        _topDot.layer.cornerRadius = self.width * 0.5
        _topDot.clipsToBounds = true
        
        _bottomDot.layer.cornerRadius = self.width * 0.5
        _bottomDot.clipsToBounds = true
        
        _topDot.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-15)
            make.size.equalTo(self.width)
        }
        
        _bottomDot.snp.makeConstraints { make in
            make.centerX.size.equalTo(_topDot)
            make.centerY.equalToSuperview().offset(15)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        deallocPrint()
    }

}
