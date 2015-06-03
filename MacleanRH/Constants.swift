//
//  Constants.swift
//  MacleanRH
//
//  Created by iem on 03/06/2015.
//  Copyright (c) 2015 iem. All rights reserved.
//

import Foundation

class Constants
{
    static let DATABASE_NAME = "MacleanRH"
    static let DATABASE_FILE = "MacleanRH.sqlite"
}


enum StateCanidature
{
    case ValidateCandidature
    case RefuseCantidature
    case IcompleteCandidature
    case WaittingValideCandidature
    case WaitingSignatureCandidature
    case FinishCandidature
}