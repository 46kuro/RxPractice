//
//  String+URL.swift
//  RxPractice
//
//  Created by Shinji Kurosawa on 2020/01/31.
//  Copyright © 2020 Shinji Kurosawa. All rights reserved.
//

import Foundation

extension String {
    var URLEscaped: String {
       return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
    }
}
