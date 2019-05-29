//
//  Equation.swift
//  Calculadora
//
//  Created by Gunther Ribak on 29/05/2019.
//  Copyright © 2019 CWI Software. All rights reserved.
//

import Foundation

struct Equation {
    let signal: Signals
    var value1: Double
    var value2: Double? = nil
    
    init(signal: Signals, value1: Double) {
        self.signal = signal
        self.value1 = value1
    }
    
}
