import Foundation
import HMUtilities

/// Name enum.
public enum AADashboardLightName: String, CaseIterable, Codable, HMBytesConvertable {
    case acc
    case activeHoodFault
    case activeSpoilerFault
    case adblueLevel
    case adjustTirePressure
    case advancedBraking
    case airFilterMinder
    case airSuspensionRideControlFault
    case airbag
    case allWheelDriveDisabled
    case antiLockBrakeFailure
    case antiPollutionFailureEngineStartImpossible
    case antiPollutionSystemFailure
    case antiReverseSystemFailing
    case antiTheft
    case autoParkingBrake
    case automaticBrakingDeactive
    case automaticBrakingSystemFault
    case automaticLightsSettingsFailure
    case batteryChargingCondition
    case batteryLowWarning
    case batterySecondaryLow
    case blindSpotDetection
    case brakeFailure
    case brakeFluidWarning
    case brakeLights
    case chargeSystemFault
    case checkFuelCap
    case checkFuelFillInlet
    case checkFuelFilter
    case checkReversingLamp
    case crossingLineSystemAlertFailure
    case dcTempWarning
    case dcWarningStatus
    case dieselEngineIdleShutdown
    case dieselEngineWarning
    case dieselExhaustFluidQuality
    case dieselExhaustFluidSystemFault
    case dieselExhaustOverTemp
    case dieselFilterRegeneration
    case dieselOilFilterWaterPresence
    case dieselParticulateFilter
    case dieselPreHeat
    case dippedBeamHeadlampsFrontLeftFailure
    case dippedBeamHeadlampsFrontRightFailure
    case directionalHeadlampsFailure
    case directionalLightFailure
    case doorFrontLeftOpen
    case doorFrontLeftOpenHighSpeed
    case doorFrontRightOpen
    case doorFrontRightOpenHighSpeed
    case doorRearLeftOpen
    case doorRearLeftOpenHighSpeed
    case doorRearRightOpen
    case doorRearRightOpenHighSpeed
    case dsgFailing
    case electricModeNotAvailable
    case electricTrailerBrakeConnection
    case electronicLockFailure
    case engineControlSystemFailure
    case engineCoolantLevel
    case engineCoolantTemperature
    case engineDragTorqueControlFailure
    case engineIndicator
    case engineOil
    case engineOilLevel
    case engineOilPressureAlert
    case escIndication
    case escSwitchedOff
    case espFailure
    case evBatteryCellMaxVoltWarning
    case evBatteryCellMinVoltWarning
    case evBatteryChargeEnergyStorageWarning
    case evBatteryHighLevelWarning
    case evBatteryHighTemperatureWarning
    case evBatteryInsulationResistWarning
    case evBatteryJumpLevelWarning
    case evBatteryLowLevelWarning
    case evBatteryMaxVoltVehEnergyWarning
    case evBatteryMinVoltVehEnergyWarning
    case evBatteryOverChargeWarning
    case evBatteryPoorCellWarning
    case evBatteryTempDiffWarning
    case excessiveOilTemperature
    case fogLightFrontFault
    case fogLightFrontLeftFailure
    case fogLightFrontRightFailure
    case fogLightRearFault
    case fogLightRearLeftFailure
    case fogLightRearRightFailure
    case forwardCollisionWarning
    case frontFogLight
    case fuelDoorOpen
    case fuelFilterDiffPressure
    case fuelLevel
    case hatchOpen
    case hazardWarning
    case headlightsLeftFailure
    case headlightsRightFailure
    case highBeam
    case hillDescentControlFault
    case hillStartAssistWarning
    case hvInterlockingStatusWarning
    case hybridSystemFault
    case hybridSystemFaultRepairedVehicle
    case hydraulicPressureOrBrakeFuildInsufficient
    case inspectionWarning
    case keyfobBatteryAlarm
    case laneDepartureFault
    case laneDepartureWarningOff
    case lightingSystemFailure
    case limitedVisibilityAidsCamera
    case lowBeam
    case maintenanceDateExceeded
    case maintenanceOdometerExceeded
    case malfunctionIndicator
    case motorControllerTempWarning
    case oilChangeWarning
    case otherFailingSystem
    case parkAidMalfunction
    case parkHeating
    case parkingBrakeControlFailing
    case parkingSpaceMeasuringSystemFailure
    case passiveEntryPassiveStart
    case placeGearToParking
    case positionLights
    case powerSteeringAssitanceFailure
    case powerSteeringFailure
    case powertrainMalfunction
    case preheatingDeactivatedBatterySetTheClock
    case preheatingDeactivatedBatteryTooLow
    case preheatingDeactivatedFuelLevelTooLow
    case rearFogLight
    case restraintsIndicatorWarning
    case retractableRoofMechanismFault
    case reverseLightLeftFailure
    case reverseLightRightFailure
    case riskOfIce
    case roofOperationImpossibleApplyParkingBreak
    case roofOperationImpossibleApplyStartEngine
    case roofOperationImpossibleTemperatureTooHigh
    case screenRearOpen
    case seatBelt
    case seatbeltPassengerFrontRightUnbuckled
    case seatbeltPassengerRearCenterUnbuckled
    case seatbeltPassengerRearLeftUnbuckled
    case seatbeltPassengerRearRightUnbuckled
    case serviceCall
    case shockSensorFailing
    case sideLightsFrontLeftFailure
    case sideLightsFrontRightFailure
    case sideLightsRearLeftFailure
    case sideLightsRearRightFailure
    case spareWheelFitterDrivingAidsDeactivated
    case speedControlFailure
    case startStopEngineWarning
    case steeringFailure
    case steeringLockAlert
    case stopLightLeftFailure
    case stopLightRightFailure
    case suspensionFailure
    case suspensionFailureReduceSpeed
    case suspensionFaultLimitedTo90Kmh
    case tireFailure
    case tireFrontLeftFlat
    case tireFrontLeftNotMonitored
    case tireFrontRightFlat
    case tireFrontRightNotMonitored
    case tirePressureLow
    case tirePressureMonitorSystemWarning
    case tirePressureSensorFailure
    case tireRearLeftFlat
    case tireRearLeftNotMonitored
    case tireRearRightFlat
    case tireRearRightNotMonitored
    case tireUnderInflation
    case tireWarningFrontLeft
    case tireWarningFrontRight
    case tireWarningRearLeft
    case tireWarningRearRight
    case tireWarningSystemError
    case tractionControlActive
    case tractionControlDisabled
    case tractionMotorTempWarning
    case trailerConnected
    case transmissionFailure
    case transmissionFluidTemperature
    case trunkOpen
    case trunkOpenHighSpeed
    case trunkWindowOpen
    case turnSignalFrontLeftFailure
    case turnSignalFrontRightFailure
    case turnSignalRearLeftFailure
    case turnSignalRearRightFailure
    case waterInFuel
    case wheelPressureFault
    case windscreenWasherFluid
    case wornBrakeLinings

    public var byteValue: UInt8 {
        switch self {
        case .highBeam: return 0x00
        case .lowBeam: return 0x01
        case .hazardWarning: return 0x02
        case .brakeFailure: return 0x03
        case .hatchOpen: return 0x04
        case .fuelLevel: return 0x05
        case .engineCoolantTemperature: return 0x06
        case .batteryChargingCondition: return 0x07
        case .engineOil: return 0x08
        case .positionLights: return 0x09
        case .frontFogLight: return 0x0a
        case .rearFogLight: return 0x0b
        case .parkHeating: return 0x0c
        case .engineIndicator: return 0x0d
        case .serviceCall: return 0x0e
        case .transmissionFluidTemperature: return 0x0f
        case .transmissionFailure: return 0x10
        case .antiLockBrakeFailure: return 0x11
        case .wornBrakeLinings: return 0x12
        case .windscreenWasherFluid: return 0x13
        case .tireFailure: return 0x14
        case .engineOilLevel: return 0x15
        case .engineCoolantLevel: return 0x16
        case .steeringFailure: return 0x17
        case .escIndication: return 0x18
        case .brakeLights: return 0x19
        case .adblueLevel: return 0x1a
        case .fuelFilterDiffPressure: return 0x1b
        case .seatBelt: return 0x1c
        case .advancedBraking: return 0x1d
        case .acc: return 0x1e
        case .trailerConnected: return 0x1f
        case .airbag: return 0x20
        case .escSwitchedOff: return 0x21
        case .laneDepartureWarningOff: return 0x22
        case .airFilterMinder: return 0x23
        case .airSuspensionRideControlFault: return 0x24
        case .allWheelDriveDisabled: return 0x25
        case .antiTheft: return 0x26
        case .blindSpotDetection: return 0x27
        case .chargeSystemFault: return 0x28
        case .checkFuelCap: return 0x29
        case .checkFuelFillInlet: return 0x2a
        case .checkFuelFilter: return 0x2b
        case .dcTempWarning: return 0x2c
        case .dcWarningStatus: return 0x2d
        case .dieselEngineIdleShutdown: return 0x2e
        case .dieselEngineWarning: return 0x2f
        case .dieselExhaustFluidSystemFault: return 0x30
        case .dieselExhaustOverTemp: return 0x31
        case .dieselExhaustFluidQuality: return 0x32
        case .dieselFilterRegeneration: return 0x33
        case .dieselParticulateFilter: return 0x34
        case .dieselPreHeat: return 0x35
        case .electricTrailerBrakeConnection: return 0x36
        case .evBatteryCellMaxVoltWarning: return 0x37
        case .evBatteryCellMinVoltWarning: return 0x38
        case .evBatteryChargeEnergyStorageWarning: return 0x39
        case .evBatteryHighLevelWarning: return 0x3a
        case .evBatteryHighTemperatureWarning: return 0x3b
        case .evBatteryInsulationResistWarning: return 0x3c
        case .evBatteryJumpLevelWarning: return 0x3d
        case .evBatteryLowLevelWarning: return 0x3e
        case .evBatteryMaxVoltVehEnergyWarning: return 0x3f
        case .evBatteryMinVoltVehEnergyWarning: return 0x40
        case .evBatteryOverChargeWarning: return 0x41
        case .evBatteryPoorCellWarning: return 0x42
        case .evBatteryTempDiffWarning: return 0x43
        case .forwardCollisionWarning: return 0x44
        case .fuelDoorOpen: return 0x45
        case .hillDescentControlFault: return 0x46
        case .hillStartAssistWarning: return 0x47
        case .hvInterlockingStatusWarning: return 0x48
        case .lightingSystemFailure: return 0x49
        case .malfunctionIndicator: return 0x4a
        case .motorControllerTempWarning: return 0x4b
        case .parkAidMalfunction: return 0x4c
        case .passiveEntryPassiveStart: return 0x4d
        case .powertrainMalfunction: return 0x4e
        case .restraintsIndicatorWarning: return 0x4f
        case .startStopEngineWarning: return 0x50
        case .tractionControlDisabled: return 0x51
        case .tractionControlActive: return 0x52
        case .tractionMotorTempWarning: return 0x53
        case .tirePressureMonitorSystemWarning: return 0x54
        case .waterInFuel: return 0x55
        case .tireWarningFrontRight: return 0x56
        case .tireWarningFrontLeft: return 0x57
        case .tireWarningRearRight: return 0x58
        case .tireWarningRearLeft: return 0x59
        case .tireWarningSystemError: return 0x5a
        case .batteryLowWarning: return 0x5b
        case .brakeFluidWarning: return 0x5c
        case .activeHoodFault: return 0x5d
        case .activeSpoilerFault: return 0x5e
        case .adjustTirePressure: return 0x5f
        case .steeringLockAlert: return 0x60
        case .antiPollutionFailureEngineStartImpossible: return 0x61
        case .antiPollutionSystemFailure: return 0x62
        case .antiReverseSystemFailing: return 0x63
        case .autoParkingBrake: return 0x64
        case .automaticBrakingDeactive: return 0x65
        case .automaticBrakingSystemFault: return 0x66
        case .automaticLightsSettingsFailure: return 0x67
        case .keyfobBatteryAlarm: return 0x68
        case .trunkOpen: return 0x69
        case .checkReversingLamp: return 0x6a
        case .crossingLineSystemAlertFailure: return 0x6b
        case .dippedBeamHeadlampsFrontLeftFailure: return 0x6c
        case .dippedBeamHeadlampsFrontRightFailure: return 0x6d
        case .directionalHeadlampsFailure: return 0x6e
        case .directionalLightFailure: return 0x6f
        case .dsgFailing: return 0x70
        case .electricModeNotAvailable: return 0x71
        case .electronicLockFailure: return 0x72
        case .engineControlSystemFailure: return 0x73
        case .engineOilPressureAlert: return 0x74
        case .espFailure: return 0x75
        case .excessiveOilTemperature: return 0x76
        case .tireFrontLeftFlat: return 0x77
        case .tireFrontRightFlat: return 0x78
        case .tireRearLeftFlat: return 0x79
        case .tireRearRightFlat: return 0x7a
        case .fogLightFrontLeftFailure: return 0x7b
        case .fogLightFrontRightFailure: return 0x7c
        case .fogLightRearLeftFailure: return 0x7d
        case .fogLightRearRightFailure: return 0x7e
        case .fogLightFrontFault: return 0x7f
        case .doorFrontLeftOpen: return 0x80
        case .doorFrontLeftOpenHighSpeed: return 0x81
        case .tireFrontLeftNotMonitored: return 0x82
        case .doorFrontRightOpen: return 0x83
        case .doorFrontRightOpenHighSpeed: return 0x84
        case .tireFrontRightNotMonitored: return 0x85
        case .headlightsLeftFailure: return 0x86
        case .headlightsRightFailure: return 0x87
        case .hybridSystemFault: return 0x88
        case .hybridSystemFaultRepairedVehicle: return 0x89
        case .hydraulicPressureOrBrakeFuildInsufficient: return 0x8a
        case .laneDepartureFault: return 0x8b
        case .limitedVisibilityAidsCamera: return 0x8c
        case .tirePressureLow: return 0x8d
        case .maintenanceDateExceeded: return 0x8e
        case .maintenanceOdometerExceeded: return 0x8f
        case .otherFailingSystem: return 0x90
        case .parkingBrakeControlFailing: return 0x91
        case .parkingSpaceMeasuringSystemFailure: return 0x92
        case .placeGearToParking: return 0x93
        case .powerSteeringAssitanceFailure: return 0x94
        case .powerSteeringFailure: return 0x95
        case .preheatingDeactivatedBatteryTooLow: return 0x96
        case .preheatingDeactivatedFuelLevelTooLow: return 0x97
        case .preheatingDeactivatedBatterySetTheClock: return 0x98
        case .fogLightRearFault: return 0x99
        case .doorRearLeftOpen: return 0x9a
        case .doorRearLeftOpenHighSpeed: return 0x9b
        case .tireRearLeftNotMonitored: return 0x9c
        case .doorRearRightOpen: return 0x9d
        case .doorRearRightOpenHighSpeed: return 0x9e
        case .tireRearRightNotMonitored: return 0x9f
        case .screenRearOpen: return 0xa0
        case .retractableRoofMechanismFault: return 0xa1
        case .reverseLightLeftFailure: return 0xa2
        case .reverseLightRightFailure: return 0xa3
        case .riskOfIce: return 0xa4
        case .roofOperationImpossibleApplyParkingBreak: return 0xa5
        case .roofOperationImpossibleApplyStartEngine: return 0xa6
        case .roofOperationImpossibleTemperatureTooHigh: return 0xa7
        case .seatbeltPassengerFrontRightUnbuckled: return 0xa8
        case .seatbeltPassengerRearLeftUnbuckled: return 0xa9
        case .seatbeltPassengerRearCenterUnbuckled: return 0xaa
        case .seatbeltPassengerRearRightUnbuckled: return 0xab
        case .batterySecondaryLow: return 0xac
        case .shockSensorFailing: return 0xad
        case .sideLightsFrontLeftFailure: return 0xae
        case .sideLightsFrontRightFailure: return 0xaf
        case .sideLightsRearLeftFailure: return 0xb0
        case .sideLightsRearRightFailure: return 0xb1
        case .spareWheelFitterDrivingAidsDeactivated: return 0xb2
        case .speedControlFailure: return 0xb3
        case .stopLightLeftFailure: return 0xb4
        case .stopLightRightFailure: return 0xb5
        case .suspensionFailure: return 0xb6
        case .suspensionFailureReduceSpeed: return 0xb7
        case .suspensionFaultLimitedTo90Kmh: return 0xb8
        case .tirePressureSensorFailure: return 0xb9
        case .trunkOpenHighSpeed: return 0xba
        case .trunkWindowOpen: return 0xbb
        case .turnSignalFrontLeftFailure: return 0xbc
        case .turnSignalFrontRightFailure: return 0xbd
        case .turnSignalRearLeftFailure: return 0xbe
        case .turnSignalRearRightFailure: return 0xbf
        case .tireUnderInflation: return 0xc0
        case .wheelPressureFault: return 0xc1
        case .oilChangeWarning: return 0xc2
        case .inspectionWarning: return 0xc3
        case .dieselOilFilterWaterPresence: return 0xc4
        case .engineDragTorqueControlFailure: return 0xc5
        }
    }

    // MARK: HMBytesConvertable
    public var bytes: [UInt8] {
        [byteValue]
    }

    public init?(bytes: [UInt8]) {
        guard let uint8 = UInt8(bytes: bytes) else {
            return nil
        }

        switch uint8 {
        case 0x00: self = .highBeam
        case 0x01: self = .lowBeam
        case 0x02: self = .hazardWarning
        case 0x03: self = .brakeFailure
        case 0x04: self = .hatchOpen
        case 0x05: self = .fuelLevel
        case 0x06: self = .engineCoolantTemperature
        case 0x07: self = .batteryChargingCondition
        case 0x08: self = .engineOil
        case 0x09: self = .positionLights
        case 0x0a: self = .frontFogLight
        case 0x0b: self = .rearFogLight
        case 0x0c: self = .parkHeating
        case 0x0d: self = .engineIndicator
        case 0x0e: self = .serviceCall
        case 0x0f: self = .transmissionFluidTemperature
        case 0x10: self = .transmissionFailure
        case 0x11: self = .antiLockBrakeFailure
        case 0x12: self = .wornBrakeLinings
        case 0x13: self = .windscreenWasherFluid
        case 0x14: self = .tireFailure
        case 0x15: self = .engineOilLevel
        case 0x16: self = .engineCoolantLevel
        case 0x17: self = .steeringFailure
        case 0x18: self = .escIndication
        case 0x19: self = .brakeLights
        case 0x1a: self = .adblueLevel
        case 0x1b: self = .fuelFilterDiffPressure
        case 0x1c: self = .seatBelt
        case 0x1d: self = .advancedBraking
        case 0x1e: self = .acc
        case 0x1f: self = .trailerConnected
        case 0x20: self = .airbag
        case 0x21: self = .escSwitchedOff
        case 0x22: self = .laneDepartureWarningOff
        case 0x23: self = .airFilterMinder
        case 0x24: self = .airSuspensionRideControlFault
        case 0x25: self = .allWheelDriveDisabled
        case 0x26: self = .antiTheft
        case 0x27: self = .blindSpotDetection
        case 0x28: self = .chargeSystemFault
        case 0x29: self = .checkFuelCap
        case 0x2a: self = .checkFuelFillInlet
        case 0x2b: self = .checkFuelFilter
        case 0x2c: self = .dcTempWarning
        case 0x2d: self = .dcWarningStatus
        case 0x2e: self = .dieselEngineIdleShutdown
        case 0x2f: self = .dieselEngineWarning
        case 0x30: self = .dieselExhaustFluidSystemFault
        case 0x31: self = .dieselExhaustOverTemp
        case 0x32: self = .dieselExhaustFluidQuality
        case 0x33: self = .dieselFilterRegeneration
        case 0x34: self = .dieselParticulateFilter
        case 0x35: self = .dieselPreHeat
        case 0x36: self = .electricTrailerBrakeConnection
        case 0x37: self = .evBatteryCellMaxVoltWarning
        case 0x38: self = .evBatteryCellMinVoltWarning
        case 0x39: self = .evBatteryChargeEnergyStorageWarning
        case 0x3a: self = .evBatteryHighLevelWarning
        case 0x3b: self = .evBatteryHighTemperatureWarning
        case 0x3c: self = .evBatteryInsulationResistWarning
        case 0x3d: self = .evBatteryJumpLevelWarning
        case 0x3e: self = .evBatteryLowLevelWarning
        case 0x3f: self = .evBatteryMaxVoltVehEnergyWarning
        case 0x40: self = .evBatteryMinVoltVehEnergyWarning
        case 0x41: self = .evBatteryOverChargeWarning
        case 0x42: self = .evBatteryPoorCellWarning
        case 0x43: self = .evBatteryTempDiffWarning
        case 0x44: self = .forwardCollisionWarning
        case 0x45: self = .fuelDoorOpen
        case 0x46: self = .hillDescentControlFault
        case 0x47: self = .hillStartAssistWarning
        case 0x48: self = .hvInterlockingStatusWarning
        case 0x49: self = .lightingSystemFailure
        case 0x4a: self = .malfunctionIndicator
        case 0x4b: self = .motorControllerTempWarning
        case 0x4c: self = .parkAidMalfunction
        case 0x4d: self = .passiveEntryPassiveStart
        case 0x4e: self = .powertrainMalfunction
        case 0x4f: self = .restraintsIndicatorWarning
        case 0x50: self = .startStopEngineWarning
        case 0x51: self = .tractionControlDisabled
        case 0x52: self = .tractionControlActive
        case 0x53: self = .tractionMotorTempWarning
        case 0x54: self = .tirePressureMonitorSystemWarning
        case 0x55: self = .waterInFuel
        case 0x56: self = .tireWarningFrontRight
        case 0x57: self = .tireWarningFrontLeft
        case 0x58: self = .tireWarningRearRight
        case 0x59: self = .tireWarningRearLeft
        case 0x5a: self = .tireWarningSystemError
        case 0x5b: self = .batteryLowWarning
        case 0x5c: self = .brakeFluidWarning
        case 0x5d: self = .activeHoodFault
        case 0x5e: self = .activeSpoilerFault
        case 0x5f: self = .adjustTirePressure
        case 0x60: self = .steeringLockAlert
        case 0x61: self = .antiPollutionFailureEngineStartImpossible
        case 0x62: self = .antiPollutionSystemFailure
        case 0x63: self = .antiReverseSystemFailing
        case 0x64: self = .autoParkingBrake
        case 0x65: self = .automaticBrakingDeactive
        case 0x66: self = .automaticBrakingSystemFault
        case 0x67: self = .automaticLightsSettingsFailure
        case 0x68: self = .keyfobBatteryAlarm
        case 0x69: self = .trunkOpen
        case 0x6a: self = .checkReversingLamp
        case 0x6b: self = .crossingLineSystemAlertFailure
        case 0x6c: self = .dippedBeamHeadlampsFrontLeftFailure
        case 0x6d: self = .dippedBeamHeadlampsFrontRightFailure
        case 0x6e: self = .directionalHeadlampsFailure
        case 0x6f: self = .directionalLightFailure
        case 0x70: self = .dsgFailing
        case 0x71: self = .electricModeNotAvailable
        case 0x72: self = .electronicLockFailure
        case 0x73: self = .engineControlSystemFailure
        case 0x74: self = .engineOilPressureAlert
        case 0x75: self = .espFailure
        case 0x76: self = .excessiveOilTemperature
        case 0x77: self = .tireFrontLeftFlat
        case 0x78: self = .tireFrontRightFlat
        case 0x79: self = .tireRearLeftFlat
        case 0x7a: self = .tireRearRightFlat
        case 0x7b: self = .fogLightFrontLeftFailure
        case 0x7c: self = .fogLightFrontRightFailure
        case 0x7d: self = .fogLightRearLeftFailure
        case 0x7e: self = .fogLightRearRightFailure
        case 0x7f: self = .fogLightFrontFault
        case 0x80: self = .doorFrontLeftOpen
        case 0x81: self = .doorFrontLeftOpenHighSpeed
        case 0x82: self = .tireFrontLeftNotMonitored
        case 0x83: self = .doorFrontRightOpen
        case 0x84: self = .doorFrontRightOpenHighSpeed
        case 0x85: self = .tireFrontRightNotMonitored
        case 0x86: self = .headlightsLeftFailure
        case 0x87: self = .headlightsRightFailure
        case 0x88: self = .hybridSystemFault
        case 0x89: self = .hybridSystemFaultRepairedVehicle
        case 0x8a: self = .hydraulicPressureOrBrakeFuildInsufficient
        case 0x8b: self = .laneDepartureFault
        case 0x8c: self = .limitedVisibilityAidsCamera
        case 0x8d: self = .tirePressureLow
        case 0x8e: self = .maintenanceDateExceeded
        case 0x8f: self = .maintenanceOdometerExceeded
        case 0x90: self = .otherFailingSystem
        case 0x91: self = .parkingBrakeControlFailing
        case 0x92: self = .parkingSpaceMeasuringSystemFailure
        case 0x93: self = .placeGearToParking
        case 0x94: self = .powerSteeringAssitanceFailure
        case 0x95: self = .powerSteeringFailure
        case 0x96: self = .preheatingDeactivatedBatteryTooLow
        case 0x97: self = .preheatingDeactivatedFuelLevelTooLow
        case 0x98: self = .preheatingDeactivatedBatterySetTheClock
        case 0x99: self = .fogLightRearFault
        case 0x9a: self = .doorRearLeftOpen
        case 0x9b: self = .doorRearLeftOpenHighSpeed
        case 0x9c: self = .tireRearLeftNotMonitored
        case 0x9d: self = .doorRearRightOpen
        case 0x9e: self = .doorRearRightOpenHighSpeed
        case 0x9f: self = .tireRearRightNotMonitored
        case 0xa0: self = .screenRearOpen
        case 0xa1: self = .retractableRoofMechanismFault
        case 0xa2: self = .reverseLightLeftFailure
        case 0xa3: self = .reverseLightRightFailure
        case 0xa4: self = .riskOfIce
        case 0xa5: self = .roofOperationImpossibleApplyParkingBreak
        case 0xa6: self = .roofOperationImpossibleApplyStartEngine
        case 0xa7: self = .roofOperationImpossibleTemperatureTooHigh
        case 0xa8: self = .seatbeltPassengerFrontRightUnbuckled
        case 0xa9: self = .seatbeltPassengerRearLeftUnbuckled
        case 0xaa: self = .seatbeltPassengerRearCenterUnbuckled
        case 0xab: self = .seatbeltPassengerRearRightUnbuckled
        case 0xac: self = .batterySecondaryLow
        case 0xad: self = .shockSensorFailing
        case 0xae: self = .sideLightsFrontLeftFailure
        case 0xaf: self = .sideLightsFrontRightFailure
        case 0xb0: self = .sideLightsRearLeftFailure
        case 0xb1: self = .sideLightsRearRightFailure
        case 0xb2: self = .spareWheelFitterDrivingAidsDeactivated
        case 0xb3: self = .speedControlFailure
        case 0xb4: self = .stopLightLeftFailure
        case 0xb5: self = .stopLightRightFailure
        case 0xb6: self = .suspensionFailure
        case 0xb7: self = .suspensionFailureReduceSpeed
        case 0xb8: self = .suspensionFaultLimitedTo90Kmh
        case 0xb9: self = .tirePressureSensorFailure
        case 0xba: self = .trunkOpenHighSpeed
        case 0xbb: self = .trunkWindowOpen
        case 0xbc: self = .turnSignalFrontLeftFailure
        case 0xbd: self = .turnSignalFrontRightFailure
        case 0xbe: self = .turnSignalRearLeftFailure
        case 0xbf: self = .turnSignalRearRightFailure
        case 0xc0: self = .tireUnderInflation
        case 0xc1: self = .wheelPressureFault
        case 0xc2: self = .oilChangeWarning
        case 0xc3: self = .inspectionWarning
        case 0xc4: self = .dieselOilFilterWaterPresence
        case 0xc5: self = .engineDragTorqueControlFailure
        default: return nil
        }
    }
}
