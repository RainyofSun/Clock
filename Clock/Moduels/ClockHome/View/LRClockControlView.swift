//
//  LRClockControlView.swift
//  Clock
//
//  Created by 苍蓝猛兽 on 2023/2/1.
//

import UIKit

class LRClockControlView: UIView {

    /// 代理
    weak open var clockOperationDelegate: ClockOperationProtocol? {
        didSet {
            self.operationView.operationDelegate = clockOperationDelegate
        }
    }
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel.init(frame: CGRect.zero)
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.regular)
        label.text = Date().weekDayFormatString
        return label
    }()
    
    private lazy var operationView: LRClockOperationView = {
        return LRClockOperationView(frame: CGRect.zero)
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadClockControlViews()
        layoutClockControlViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        deallocPrint()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        operationView.showOperation()
    }
}

private extension LRClockControlView {
    func loadClockControlViews() {
        self.backgroundColor = .clear
        self.addSubview(dateLabel)
        self.addSubview(operationView)
    }
    
    func layoutClockControlViews() {
        dateLabel.snp.makeConstraints { make in
            make.horizontalEdges.top.equalToSuperview()
            make.height.equalTo(dateLabel.font.pointSize + 3)
        }
        
        operationView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
