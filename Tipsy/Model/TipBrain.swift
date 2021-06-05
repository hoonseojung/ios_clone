//
//  TipBrain.swift
//  Tipsy
//
//  Created by 정훈서 on 2021/06/05.
//  Copyright © 2021 The App Brewery. All rights reserved.
//

import UIKit

struct TipBrain {
    
    var tip : TIP?
    
    func getTotalValue() -> String {
        let totalValue = String(format: "%.2f", tip?.totalvalue ?? 0.00)
        return totalValue
    }
    
    mutating func getSetting(value: Double, tipPercent:) -> String {
        tip = TIP(totalvalue: <#T##Double#>, tipPct: <#Double#>, split: <#T##Int#>, notice: "Split between \(tip!.split) people, with \(tip?.totalvalue ?? 0.00)% tip.")
        return tip!.notice
    }
}
