//
//  TestStaticFramework.swift
//  Symbols
//
//  Created by xiong有都 on 2024/1/20.
//

import Foundation
import StaticFramework

func testStaticFramework() {
    let info = getDataFromStatic()
    print(info)
}

func getDataFromStatic() -> String {
    let staticProvider = DataProviderFromStatic(age: 13, name: "lucy")
    let info = staticProvider.provideData()
    return info
}
