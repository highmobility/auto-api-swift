//
// AutoAPITests
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

#if os(macOS) || os(iOS) || os(tvOS) || os(watchOS)
    // Hello my darling
#else
import XCTest
@testable import AutoAPITests

XCTMain([
    testCase(BrowserTests.allTests),
    testCase(CapabilitiesTests.allTests),
    testCase(ChargingTests.allTests),
    testCase(ChassisSettingsTests.allTests),
    testCase(ClimateTests.allTests),
    testCase(CruiseControlTests.allTests),
    testCase(DashboardLightsTests.allTests),
    testCase(DiagnosticsTests.allTests),
    testCase(DoorLocksTests.allTests),
    testCase(DriverFatigueTests.allTests),
    testCase(EngineTests.allTests),
    testCase(FailureMessageTests.allTests),
    testCase(FirmwareVersionTests.allTests),
    testCase(FuelingTests.allTests),
    testCase(GraphicsTests.allTests),
    testCase(HeartRateTests.allTests),
    testCase(HomeChargerTests.allTests),
    testCase(HonkHornFlashLightsTests.allTests),
    testCase(KeyfobPositionTests.allTests),
    testCase(LightConditionsTests.allTests),
    testCase(LightsTests.allTests),
    testCase(MaintenanceTests.allTests),
    testCase(MessagingTests.allTests),
    testCase(NaviDestinationTests.allTests),
    testCase(NotificationsTests.allTests),
    testCase(OffroadTests.allTests),
    testCase(ParkingBrakeTests.allTests),
    testCase(ParkingTicketTests.allTests),
    testCase(PowerTakeOffTests.allTests),
    testCase(PropertiesTests.allTests),
    testCase(RaceTests.allTests),
    testCase(RemoteControlTests.allTests),
    testCase(SeatsTests.allTests),
    testCase(StartStopTests.allTests),
    testCase(TachographTests.allTests),
    testCase(TextInputTests.allTests),
    testCase(TrunkAccessTests.allTests),
    testCase(TheftAlarmTests.allTests),
    testCase(ValetModeTests.allTests),
    testCase(VehicleLocationTests.allTests),
    testCase(VehicleStatusTests.allTests),
    testCase(VehicleTimeTests.allTests),
    testCase(VideoHandoverTests.allTests),
    testCase(WakeUpTests.allTests),
    testCase(WeatherConditionsTests.allTests),
    testCase(WiFiTests.allTests),
    testCase(WindowsTests.allTests),
    testCase(WindscreenTests.allTests),
])
#endif
