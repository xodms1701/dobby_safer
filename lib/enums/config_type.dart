enum ConfigType {
  overtimeWork,
  holidayWorkWithinEight,
  holidayWorkOverEight,
  nightShift,
  undefined
}

ConfigType parseToType(String value) {
  if (value == "overtimeWork") {
    return ConfigType.overtimeWork;
  } else if (value == "holidayWorkWithinEight") {
    return ConfigType.holidayWorkWithinEight;
  } else if (value == "holidayWorkOverEight") {
    return ConfigType.holidayWorkOverEight;
  } else if (value == "nightShift") {
    return ConfigType.nightShift;
  }
  return ConfigType.undefined;
}