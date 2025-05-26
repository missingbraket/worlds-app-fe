//
//  Answer.swift
//  WorldStudy-v10
//
//  Created by 이서하 on 5/23/25.
//

// (멘토)질문게시판 속 답변 데이터 모델링
import Foundation

struct Answer: Codable, Identifiable, Hashable {
    let id: Int
    let content: String
    let userId: String
    let questionId: Date
    let createdAt: Date
    let deletedAt: Date?
}
