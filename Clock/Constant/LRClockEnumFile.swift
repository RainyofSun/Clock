//
//  LRClockEnumFile.swift
//  Clock
//
//  Created by 苍蓝猛兽 on 2023/2/2.
//

import UIKit

// MARK: 枚举类型
/// 时钟类型
enum ClockType {
    /// 本地时钟
    case LocalClock
    /// 世界时钟
    case WordClock
    /// 闹钟
    case AlarmClock
}

/// 时钟外貌类型
enum ClockExterior {
    /// 黑白文字
    case BlackAndWhiteText
    /// 机械风文字
    case MechanicalStyleText
    /// 带秒针的表盘
    case SecondsDial
    /// 不带秒针的表盘
    case Dial
}

/// 表盘动画模式
enum DailHandAnimationMode {
    /// 顺滑模式
    case Smooth
    /// 跳跃模式
    case Spring
}
