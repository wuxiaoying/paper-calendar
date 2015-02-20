(function() {
  Polymer({
    weekdays: moment.weekdays(),
    today: moment(),
    ready: function() {
      var weekday;
      this.weekdaysDisplay = (function() {
        var _i, _len, _ref, _results;
        _ref = this.weekdays;
        _results = [];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          weekday = _ref[_i];
          _results.push(weekday[0]);
        }
        return _results;
      }).call(this);
    },
    attached: function() {
      if (!this.value) {
        this.value = this.today;
      }
    },
    valueChanged: function() {
      var currentMonth, iterator, month, numWeeks, week, weekIndex, weekday, _i, _j, _len, _ref;
      numWeeks = Math.ceil(this.value.daysInMonth() / this.weekdays.length);
      currentMonth = this.value.get('month');
      this.monthDisplay = this.value.format('MMMM YYYY');
      iterator = this.value.clone().startOf('month').startOf('week');
      this.month = [];
      for (weekIndex = _i = 0; 0 <= numWeeks ? _i < numWeeks : _i > numWeeks; weekIndex = 0 <= numWeeks ? ++_i : --_i) {
        week = [];
        _ref = this.weekdays;
        for (_j = 0, _len = _ref.length; _j < _len; _j++) {
          weekday = _ref[_j];
          month = iterator.get('month');
          week.push({
            date: iterator.get('date'),
            month: month,
            isToday: iterator.isSame(this.today, 'd'),
            isEvent: this._IsEvent(iterator),
            inCurrentMonth: month === currentMonth
          });
          iterator.add(1, 'd');
        }
        this.month.push(week);
      }
    },
    onDateSelect: function(e, detail) {
      this.fire('date-change');
    },
    _IsEvent: function(date) {
      var event, _i, _len, _ref;
      _ref = this.events || [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        event = _ref[_i];
        if (event.isSame(date)) {
          return true;
        }
      }
      return false;
    }
  });

}).call(this);