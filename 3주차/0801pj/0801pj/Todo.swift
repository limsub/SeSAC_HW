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
        ToDo(done: false, main: "밥 먹기", special: true),
        ToDo(done: false, main: "고기먹기", special: true),
        ToDo(done: false, main: "집 사기", special: true),
        ToDo(done: false, main: "바지 사기", special: true),
        ToDo(done: false, main: "책상 고치기", special: true),
        ToDo(done: false, main: "핸드폰 사기", special: true),
        ToDo(done: false, main: "노트북 고치기", special: true),
    ]
    
    var todoList: [ToDo] = [
        ToDo(done: false, main: "마우스 사기", special: false),
        ToDo(done: false, main: "키보드 사기", special: false),
        ToDo(done: false, main: "책상 사기", special: false),
        ToDo(done: false, main: "저녁 먹기", special: false),
        ToDo(done: false, main: "아침 먹기", special: false),
        ToDo(done: false, main: "책 읽기", special: false),
        ToDo(done: false, main: "공부하기", special: false),
        ToDo(done: false, main: "클로저 공부하기", special: false),
        ToDo(done: false, main: "프로토콜 공부하기", special: false),
        ToDo(done: false, main: "클래스와 구조체의 차이는", special: false),
        ToDo(done: false, main: "아오 졸려", special: false),

    ]
    
    var doneList: [ToDo] = []
}

enum Option: String {
    case 즐겨찾기
    case 일반
}
