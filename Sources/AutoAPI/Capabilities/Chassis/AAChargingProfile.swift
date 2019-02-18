//
// AutoAPI
// Copyright (C) 2018 High-Mobility GmbH
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
//  AAChargingProfile.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 28/08/2018.
//  Copyright © 2018 High Mobility. All rights reserved.
//

import Foundation


/*

 <wt>

    DEPARTURE_TIMES

     <departureTimes>
         <departureTime1Active>
             <deactivate/>
         </departureTime1Active>
         <departureTime1>
             <hours>15</hours>
             <minutes>30</minutes>
         </departureTime1>

         <departureTime2Active>
             <deactivate/>
         </departureTime2Active>
         <departureTime2>
             <hours>8</hours>
             <minutes>0</minutes>
         </departureTime2>

         <departureTime3Active>
             <deactivate/>
         </departureTime3Active>
         <departureTime3>
             <hours>8</hours>
             <minutes>0</minutes>
         </departureTime3>

         <departureTime4Active>
             <deactivate/>
         </departureTime4Active>
     </departureTimes>


    CLIMATISATION_ACTIVE – activeState

     <climatisationOn>
         <isTrue/>
     </climatisationOn>


    REDUCTION_OF_CHARGE_CURRENT_TIMES – dayTime

     <reductionOfChargeCurrent>
         <start>
             <hours>0</hours>
             <minutes>0</minutes>
         </start>
         <end>
             <hours>0</hours>
             <minutes>0</minutes>
         </end>
     </reductionOfChargeCurrent>


    CHARGE_MODE – immediate / timerBased

     <immediateCharging>
         <isTrue/>
     </immediateCharging>

 < /wt>

 */

