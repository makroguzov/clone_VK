//
//  Post.swift
//  vk
//
//  Created by MACUSER on 23.08.2020.
//  Copyright © 2020 MACUSER. All rights reserved.
//

import UIKit

class Post: Codable {
    let type: String //— тип списка новости, соответствующий одному из значений параметра filters;
    let source_id: Int // идентификатор источника новости (положительный — новость пользователя, отрицательный — новость группы);
    let date: String //— время публикации новости в формате unixtime;
    let post_id: Int //— находится в записях со стен и содержит идентификатор записи на стене владельца;

    let text: String //— находится в записях со стен и содержит текст записи;
}
