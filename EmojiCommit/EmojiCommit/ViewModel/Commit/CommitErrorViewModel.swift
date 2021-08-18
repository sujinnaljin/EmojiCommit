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
            return I18N.internetErrorMessage
        case .clientError:
            return I18N.clientErrorMesage
        case .serverError:
            return I18N.serverErrorMessage
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
