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
        ToDo(done: false, main: "가나다라마", special: true),
        ToDo(done: false, main: "고니다러나다라마", special: true),
        ToDo(done: false, main: "가나다바더즈딕라마", special: true),
        ToDo(done: false, main: "가더아디도라나다라마", special: true),
        ToDo(done: false, main: "가나아에이오우다라마", special: true),
        ToDo(done: false, main: "가나다라으도저답마", special: true),
        ToDo(done: false, main: "가나다라마applebanana쟈드조류자", special: true),
    ]
    
    var todoList: [ToDo] = [
        ToDo(done: false, main: "아이에으", special: false),
        ToDo(done: false, main: "아사서드도그운오", special: false),
        ToDo(done: false, main: "아이에으wienekroiewn우", special: false),
        ToDo(done: false, main: "아가나다람밥하닫이", special: false),
        ToDo(done: false, main: "아코끼리비행기바나나", special: false),
        ToDo(done: false, main: "아책상의자연필", special: false),
        ToDo(done: false, main: "아이에desk", special: false),
        ToDo(done: false, main: "아이applemacbook에으", special: false),
        ToDo(done: false, main: "오으다고지아이에", special: false),
        ToDo(done: false, main: "처오댜젇아이에으", special: false),
        ToDo(done: false, main: "he is sleeping", special: false),

    ]
    
    var doneList: [ToDo] = []
}

enum Option: String {
    case 즐겨찾기
    case 일반
}
