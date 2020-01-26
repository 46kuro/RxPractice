//
//  UIViewController+Instantiatable.swift
//  RxPractice
//
//  Created by Shinji Kurosawa on 2020/01/26.
//  Copyright © 2020 Shinji Kurosawa. All rights reserved.
//

import UIKit

extension UIViewController {
    
    static func instantiate() -> UIViewController {
        let storyboard = UIStoryboard(name: String(describing: Self.self), bundle: Bundle(for: Self.self))
        return storyboard.instantiateInitialViewController() as! Self
    }
}
