//
//  stateMachine.swift
//  UV Index
//
//  Created by Matt Ridenhour on 11/2/20.
//  Copyright © 2020 Matt Ridenhour. All rights reserved.
//

import Foundation

class StateMachine
{
    enum State {
        case firstLaunch, coreDataCall, apiCall, error
    }
}
