//
//  Extension.swift
//  ChatAppMessenger
//
//  Created by Yeojaeng on 2020/10/13.
//

import Foundation
import UIKit

extension UIView {

    public var width: CGFloat {
        return self.frame.size.width
    }

    public var height: CGFloat {
        return self.frame.size.height
    }

    public var top: CGFloat {
        return self.frame.origin.y
    }

    public var bottom: CGFloat {
        return self.frame.size.height + self.frame.origin.y
    }

    public var left: CGFloat {
        return self.frame.origin.x
    }

    public var right: CGFloat {
        return self.frame.size.width + self.frame.origin.x
    }
}
