

/// 下拉刷新视图,负责显示

import UIKit


/**
 ios 旋转动画
  - 默认顺时针旋转  
  - 就近原则
  - 要想实现同方向旋转 需要调整一个 非常小的数值
  - 如果要想实现 360 旋转 需要核心动画 CABaseAnimation
 */
class WBRefreshView: UIView {

    var refreshStatus: WBRefreshStaus = .Normal {
    
        didSet {
            switch refreshStatus {
            case .Normal:
                tipIcon?.isHidden = false
                tipIndicator?.stopAnimating()
                tipLab?.text = "继续使劲拉..."
                UIView.animate(withDuration: 0.25, animations: { 
                    self.tipIcon?.transform = CGAffineTransform.identity
                })
            case .Pulling:
                tipLab?.text = "放手就刷新..."
                UIView.animate(withDuration: 0.25, animations: { 
                    self.tipIcon?.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI - 0.001))
                })
            case .WillRefresh:
                tipLab?.text = "正在刷新中..."
                tipIcon?.isHidden = true
                tipIndicator?.startAnimating()
            }
        }
    }
    /// 提示标签
    @IBOutlet weak var tipLab: UILabel?
    /// 指示图标
    @IBOutlet weak var tipIcon: UIImageView?
    /// 指示器
    @IBOutlet weak var tipIndicator: UIActivityIndicatorView?
    
    // 父视图高度
    var parentViewHeight: CGFloat = 0 

    class func refreshView() ->WBRefreshView {
    
        let nib = UINib(nibName: "WBMTRefreshView", bundle: nil)
        return nib.instantiate(withOwner: nil, options: nil)[0] as! WBRefreshView
    }
}
