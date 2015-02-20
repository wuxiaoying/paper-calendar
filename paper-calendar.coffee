Polymer
  weekdays: moment.weekdays()
  today: moment()

  ready: ->
    @weekdaysDisplay = (weekday[0] for weekday in @weekdays)
    return

  attached: ->
    @value = @today if not @value
    return

  valueChanged: ->
    numWeeks = Math.ceil @value.daysInMonth() / @weekdays.length
    currentMonth = @value.get 'month'
    @monthDisplay = @value.format 'MMMM YYYY'

    iterator = @value.clone().startOf('month').startOf('week')
    @month = []
    for weekIndex in [0...numWeeks]
      week = []
      for weekday in @weekdays
        month = iterator.get 'month'

        week.push
          raw: iterator.clone()
          date: iterator.get 'date'
          month: month
          isToday: iterator.isSame @today, 'd'
          isEvent: @_IsEvent iterator
          inCurrentMonth: month is currentMonth

        iterator.add 1, 'd'

      @month.push week

    return

  onSelected: (e, detail) ->
    @selectedDate?.selected = false
    @selectedDate = detail
    @fire 'date-change', detail.raw
    return

  _IsEvent: (date) ->
    for event in @events or []
      if event.isSame date
        return true

    false
