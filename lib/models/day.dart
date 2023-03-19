class Day {
  /* 기준 날짜 */
  final String targetDate;
  /* 시작 시간 */
  final String startTime;
  /* 종료 시간 */
  final String endTime;
  /* 연장근무수당 */
  final int? overtimeWork;
  /* 8시간 이내 휴일근무수당 */
  final int? holidayWorkWithinEight;
  /* 8시간 초과 휴일근무수당 */
  final int? holidayWorkOverEight;
  /* 야간 근무 수당 */
  final int? nightShift;

  Day(this.holidayWorkWithinEight,
      this.holidayWorkOverEight,
      this.overtimeWork,
      this.nightShift,
      {
        required this.targetDate,
        required this.startTime,
        required this.endTime
      });
}