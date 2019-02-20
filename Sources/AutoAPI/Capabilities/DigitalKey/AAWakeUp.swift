//
// AutoAPI
// Copyright (C) 2019 High-Mobility GmbH
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program. If not, see http://www.gnu.org/licenses/.
//
// Please inquire about commercial licensing options at
// licensing@high-mobility.com
//
//
//  AAWakeUp.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 29/11/2017.
//  Copyright © 2019 High Mobility GmbH. All rights reserved.
//

import Foundation


public class AAWakeUp: AACapabilityClass, AACapability {

    public static var identifier: AACommandIdentifier = 0x0022
}

extension AAWakeUp: AAMessageTypesGettable {

    public enum MessageTypes: UInt8, CaseIterable {

        case wakeUp = 0x02
    }
}

public extension AAWakeUp {

    static var wakeUp: AACommand {
        return command(forMessageType: .wakeUp)
    }
}
