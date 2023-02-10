//
//  LRFoldClockImageElement.swift
//  Clock
//
//  Created by 苍蓝猛兽 on 2023/1/31.
//

import UIKit

class LRFoldClockImageElement: LRFoldClockBaseElement {

    // 当前时间ImageView
    private lazy var _timeImgView: UIImageView = UIImageView.init(frame: CGRect.zero)
    // 下一个时间的ImgView
    private lazy var _nextImgView: UIImageView = UIImageView.init(frame: CGRect.zero)

    override func loadFoldClockElementViews() {
        super.loadFoldClockElementViews()
        
        _timeImgView.contentMode = .scaleAspectFit
        _timeContainer.addSubview(_timeImgView)
    }
    
    override func layoutFoldClockElementViews() {
        super.layoutFoldClockElementViews()
        _timeImgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func updateTime(time: Int, nextTime: Int) {
        _timeImgView.image = UIImage.init(named: String(time))
        UIView.animate(withDuration: 0.3, delay: 0.2, options: UIView.AnimationOptions.curveEaseIn) {
            self._timeImgView.alpha = 0
        } completion: { _ in
            self._timeImgView.image = UIImage.init(named: String(nextTime))
            UIView.animate(withDuration: 0.3, delay: 0.2, options: UIView.AnimationOptions.curveEaseOut) {
                self._timeImgView.alpha = 1
            }
        }
    }
}
