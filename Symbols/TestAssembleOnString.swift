//
//  TestAssembleOnString.swift
//  Symbols
//
//  Created by xiong有都 on 2024/1/20.
//

import Foundation

func testAssembelOnString() {
    testShortString()
    testLongString()
}

func printShortStr(_ str: String) {
    print(str)
}

func testShortString() {
    let str = "lily"
    printShortStr(str)
}

func testLongString() {
    let str = "What can I do for you"
    printShortStr(str)
}
