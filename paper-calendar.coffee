Polymer
  weekdays: moment.weekdays()
  today: moment()

  ready: ->
    @weekdaysDisplay = (weekday[0] for weekday in @weekdays)
    @referenceDay = @today.clone()
    return

  referenceDayChanged: ->
    currentMonth = @referenceDay.get 'month'
    numWeeks = Math.ceil @referenceDay.daysInMonth() / @weekdays.length
    @monthDisplay = @referenceDay.format 'MMMM YYYY'

    iterator = @referenceDay.clone().startOf('month').startOf('week')
    @month = []
    for weekIndex in [0...numWeeks]
      week = []
      for weekday in @weekdays
        month = iterator.get 'month'

        week.push
          raw: iterator.clone()
          date: iterator.get 'date'
          month: month
          isToday: iterator.isSame @today, 'day'
          isEvent: @_IsEvent iterator
          inCurrentMonth: month is currentMonth

        iterator.add 1, 'd'

      @month.push week

    return

  goNextMonth: ->
    @referenceDay.add 1, 'month'
    @referenceDayChanged()
    return

  goPrevMonth: ->
    @referenceDay.subtract 1, 'month'
    @referenceDayChanged()
    return

  onSelected: (e, detail) ->
    @selectedDate?.selected = false
    @selectedDate = detail
    @fire 'date-change', detail.raw
    return

  _IsEvent: (date) ->
    for event in @events or []
      if event.isSame date, 'day'
        return true

    false
