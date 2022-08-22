//
//  PanContainerView.swift
//  PanModal
//
//  Copyright © 2018 Tiny Speck, Inc. All rights reserved.
//

#if os(iOS)
import UIKit

/**
 A view wrapper around the presented view in a PanModal transition.

 This allows us to make modifications to the presented view without
 having to do those changes directly on the view
 */
class PanContainerView: UIView {

    init(presentedView: UIView, frame: CGRect, cornerRadius: CGFloat?, showShadow: Bool? = true) {
        super.init(frame: frame)
        
        if let cornerRadius = cornerRadius {
            presentedView.layer.cornerRadius = cornerRadius
            presentedView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        }
        
        if let showShadow = showShadow,
           showShadow
        {
            let shadowPath = UIBezierPath(roundedRect: presentedView.bounds, cornerRadius: 0)
            presentedView.layer.shadowPath = shadowPath.cgPath
            presentedView.layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
            presentedView.layer.shadowOffset = CGSize(width: 0, height: 2)
            presentedView.layer.shadowRadius = 15
            presentedView.layer.shadowOpacity = 1
        }
        
        addSubview(presentedView)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension UIView {

    /**
     Convenience property for retrieving a PanContainerView instance
     from the view hierachy
     */
    var panContainerView: PanContainerView? {
        return subviews.first(where: { view -> Bool in
            view is PanContainerView
        }) as? PanContainerView
    }

}
#endif
