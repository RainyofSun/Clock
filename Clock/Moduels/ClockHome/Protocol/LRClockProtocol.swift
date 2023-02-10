//
//  LRClockProtocol.swift
//  Clock
//
//  Created by 苍蓝猛兽 on 2023/2/2.
//

import UIKit

// MARK: 代理类
/// 时钟操作界面的代理
protocol ClockOperationProtocol: AnyObject {
    /// 显示世界时钟
    func clock_showWordClock()
    /// 显示设置界面
    func clock_showClockSetting()
    /// 切换时钟样式
    func clock_switchLocalClockExterior(isLeft: Bool)
    /// 设置闹钟
    func clock_showAlarmClockSetting()
    /// 显示/隐藏dot
    func clock_showOrHideClockDot(isShow: Bool)
    /// 显示帮助界面
    func clock_showClockHelping()
}
