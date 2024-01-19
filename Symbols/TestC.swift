//
//  TestC.swift
//  Symbols
//
//  Created by xiong有都 on 2024/1/20.
//

import Foundation

func testC() {
    let pid = getPid()
    print(pid)
    
    var counter = increamentByOne()
    print(counter)
    counter = increamentByOne()
    print(counter)
}

func getPid() -> Int32 {
    let pid = getPidInfo()
    return pid
}

func increamentByOne() -> Int32 {
    let counter = increamentCount()
    return counter
}
