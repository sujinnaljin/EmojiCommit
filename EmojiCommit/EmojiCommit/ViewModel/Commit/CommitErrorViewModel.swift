//
//  CommitErrorViewModel.swift
//  EmojiCommit
//
//  Created by 강수진 on 2021/05/01.
//

import Foundation

class CommitErrorViewModel {
    private let error: APIServiceError
    var errorEmoji: String {
        switch error {
        case .clientError:
            return "🤔"
        default:
            return "😞"
        }
    }
    var errorText: String {
        switch error {
        case .internetError:
            return "네트워크 에러입니다. 인터넷 연결상태를 확인해주세요."
        case .clientError:
            return "ID를 다시 입력해주세요."
        case .serverError:
            return "탭해서 다시 시도해주세요."
        case .customError(let message):
            return message
        case .unknowError(let message):
            return message
        }
    }
    
    init(error: APIServiceError) {
        self.error = error
    }
}
