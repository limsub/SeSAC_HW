//
//  Todo.swift
//  0801pj
//
//  Created by 임승섭 on 2023/08/01.
//

import Foundation

struct ToDo {
    var done: Bool
    var main: String
    var special: Bool
}


enum identifier: String{
    case TodoTableViewCell
}


class ToDoInformation {
    var specialList: [ToDo] = [
        ToDo(done: false, main: "잠자기", special: true),
        ToDo(done: false, main: "잠자기2", special: true),
        ToDo(done: false, main: "잠자기3", special: true)
    ]
    
    var todoList: [ToDo] = [
        ToDo(done: false, main: "밥먹기", special: false),
        ToDo(done: false, main: "밥먹기2", special: false),
        ToDo(done: false, main: "밥먹기3", special: false),
        ToDo(done: false, main: "밥먹기4", special: false)
    ]
    
    var doneList: [ToDo] = []
}

enum Option: String {
    case 즐겨찾기
    case 일반
}
