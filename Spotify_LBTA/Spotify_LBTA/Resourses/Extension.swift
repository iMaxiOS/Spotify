//
//  Extension.swift
//  Spotify_LBTA
//
//  Created by Maxim Granchenko on 05.08.2021.
//

import Foundation
import UIKit

extension UIView {
    
    var width: CGFloat {
        return frame.size.width
    }
    
    var height: CGFloat {
        return frame.size.height
    }
    
    var left: CGFloat {
        return frame.origin.x
    }
    
    var right: CGFloat {
        return width + left
    }
    
    var top: CGFloat {
        return frame.origin.y
    }
    
    var bottom: CGFloat {
        return top + height
    }
}
