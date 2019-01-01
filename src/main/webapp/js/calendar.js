(function() {
  var $, Calendar, DAYS, DateRangePicker, MONTHS, TEMPLATE;

  $ = jQuery;

  DAYS = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];

  MONTHS = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];

  TEMPLATE = "<div class=\"drp-popup\">\n  <div class=\"drp-timeline\">\n    <ul class=\"drp-timeline-presets\"></ul>\n    <div class=\"drp-timeline-bar\"></div>\n  </div>\n  <div class=\"drp-calendars\">\n    <div class=\"drp-calendar drp-calendar-start\">\n      <div class=\"drp-month-picker\">\n        <div class=\"drp-arrow\"><</div>\n        <div class=\"drp-month-title\"></div>\n        <div class=\"drp-arrow drp-arrow-right\">></div>\n      </div>\n      <ul class=\"drp-day-headers\"></ul>\n      <ul class=\"drp-days\"></ul>\n      <div class=\"drp-calendar-date\"></div>\n    </div>\n    <div class=\"drp-calendar-separator\"></div>\n    <div class=\"drp-calendar drp-calendar-end\">\n      <div class=\"drp-month-picker\">\n        <div class=\"drp-arrow\"><</div>\n        <div class=\"drp-month-title\"></div>\n        <div class=\"drp-arrow drp-arrow-right\">></div>\n      </div>\n      <ul class=\"drp-day-headers\"></ul>\n      <ul class=\"drp-days\"></ul>\n      <div class=\"drp-calendar-date\"></div>\n    </div>\n  </div>\n  <div class=\"drp-tip\"></div>\n</div>";

  DateRangePicker = (function() {
    function DateRangePicker($select) {
      this.$select = $select;
      this.$dateRangePicker = $(TEMPLATE);
      this.$select.attr('tabindex', '-1').before(this.$dateRangePicker);
      this.isHidden = true;
      this.customOptionIndex = this.$select[0].length - 1;
      this.initBindings();
      this.setRange(this.$select.val());
    }

    DateRangePicker.prototype.initBindings = function() {
      var self;
      self = this;
      this.$select.on('focus mousedown', function(e) {
        var $select;
        $select = this;
        setTimeout(function() {
          return $select.blur();
        }, 0);
        return false;
      });
      this.$dateRangePicker.click(function(evt) {
        return evt.stopPropagation();
      });
      $('body').click(function(evt) {
        if (evt.target === self.$select[0] && self.isHidden) {
          return self.show();
        } else if (!self.isHidden) {
          return self.hide();
        }
      });
      this.$select.children().each(function() {
        return self.$dateRangePicker.find('.drp-timeline-presets').append($("<li class='" + ((this.selected && 'drp-selected') || '') + "'>" + ($(this).text()) + "<div class='drp-button'></div></li>"));
      });
      return this.$dateRangePicker.find('.drp-timeline-presets li').click(function(evt) {
        var presetIndex;
        $(this).addClass('drp-selected').siblings().removeClass('drp-selected');
        presetIndex = $(this).index();
        self.$select[0].selectedIndex = presetIndex;
        self.setRange(self.$select.val());
        if (presetIndex === self.customOptionIndex) {
          return self.showCustomDate();
        }
      });
    };

    DateRangePicker.prototype.hide = function() {
      this.isHidden = true;
      return this.$dateRangePicker.hide();
    };

    DateRangePicker.prototype.show = function() {
      this.isHidden = false;
      return this.$dateRangePicker.show();
    };

    DateRangePicker.prototype.showCustomDate = function() {
      var text;
      this.$dateRangePicker.find('.drp-timeline-presets li:last-child').addClass('drp-selected').siblings().removeClass('drp-selected');
      text = this.formatDate(this.startDate()) + ' - ' + this.formatDate(this.endDate());
      this.$select.find('option:last-child').text(text);
      return this.$select[0].selectedIndex = this.customOptionIndex;
    };

    DateRangePicker.prototype.formatDate = function(d) {
      return "" + (d.getMonth() + 1) + "/" + (d.getDate()) + "/" + (d.getFullYear().toString().substr(2, 2));
    };

    DateRangePicker.prototype.setRange = function(daysAgo) {
      var endDate, startDate;
      if (isNaN(daysAgo)) {
        return false;
      }
      daysAgo -= 1;
      endDate = new Date();
      startDate = new Date();
      startDate.setDate(endDate.getDate() - daysAgo);
      this.startCalendar = new Calendar(this, this.$dateRangePicker.find('.drp-calendar:first-child'), startDate, true);
      this.endCalendar = new Calendar(this, this.$dateRangePicker.find('.drp-calendar:last-child'), endDate, false);
      return this.draw();
    };

    DateRangePicker.prototype.endDate = function() {
      return this.endCalendar.date;
    };

    DateRangePicker.prototype.startDate = function() {
      return this.startCalendar.date;
    };

    DateRangePicker.prototype.draw = function() {
      this.startCalendar.draw();
      return this.endCalendar.draw();
    };

    return DateRangePicker;

  })();

  Calendar = (function() {
    function Calendar(dateRangePicker, $calendar, date, isStartCalendar) {
      var self;
      this.dateRangePicker = dateRangePicker;
      this.$calendar = $calendar;
      this.date = date;
      this.isStartCalendar = isStartCalendar;
      self = this;
      this.date.setHours(0, 0, 0, 0);
      this._visibleMonth = this.month();
      this._visibleYear = this.year();
      this.$title = this.$calendar.find('.drp-month-title');
      this.$dayHeaders = this.$calendar.find('.drp-day-headers');
      this.$days = this.$calendar.find('.drp-days');
      this.$dateDisplay = this.$calendar.find('.drp-calendar-date');
      $calendar.find('.drp-arrow').click(function(evt) {
        if ($(this).hasClass('drp-arrow-right')) {
          self.showNextMonth();
        } else {
          self.showPreviousMonth();
        }
        return false;
      });
    }

    Calendar.prototype.showPreviousMonth = function() {
      if (this._visibleMonth === 1) {
        this._visibleMonth = 12;
        this._visibleYear -= 1;
      } else {
        this._visibleMonth -= 1;
      }
      return this.draw();
    };

    Calendar.prototype.showNextMonth = function() {
      if (this._visibleMonth === 12) {
        this._visibleMonth = 1;
        this._visibleYear += 1;
      } else {
        this._visibleMonth += 1;
      }
      return this.draw();
    };

    Calendar.prototype.setDay = function(day) {
      this.setDate(this.visibleYear(), this.visibleMonth(), day);
      return this.dateRangePicker.showCustomDate();
    };

    Calendar.prototype.setDate = function(year, month, day) {
      this.date = new Date(year, month - 1, day);
      return this.dateRangePicker.draw();
    };

    Calendar.prototype.draw = function() {
      var day, _i, _len;
      this.$dayHeaders.empty();
      this.$title.text("" + (this.nameOfMonth(this.visibleMonth())) + " " + (this.visibleYear()));
      for (_i = 0, _len = DAYS.length; _i < _len; _i++) {
        day = DAYS[_i];
        this.$dayHeaders.append($("<li>" + (day.substr(0, 2)) + "</li>"));
      }
      this.drawDateDisplay();
      return this.drawDays();
    };

    Calendar.prototype.dateIsSelected = function(date) {
      return date.getTime() === this.date.getTime();
    };

    Calendar.prototype.dateIsInRange = function(date) {
      return date >= this.dateRangePicker.startDate() && date <= this.dateRangePicker.endDate();
    };

    Calendar.prototype.dayClass = function(day, firstDayOfMonth, lastDayOfMonth) {
      var classes, date;
      date = new Date(this.visibleYear(), this.visibleMonth() - 1, day);
      classes = '';
      if (this.dateIsSelected(date)) {
        classes = 'drp-day-selected';
      } else if (this.dateIsInRange(date)) {
        classes = 'drp-day-in-range';
        if (date.getTime() === this.dateRangePicker.endDate().getTime()) {
          classes += ' drp-day-last-in-range';
        }
      } else if (this.isStartCalendar) {
        if (date > this.dateRangePicker.endDate()) {
          classes += ' drp-day-disabled';
        }
      } else if (date < this.dateRangePicker.startDate()) {
        classes += ' drp-day-disabled';
      }
      if ((day + firstDayOfMonth - 1) % 7 === 0 || day === lastDayOfMonth) {
        classes += ' drp-day-last-in-row';
      }
      return classes;
    };

    Calendar.prototype.drawDays = function() {
      var firstDayOfMonth, i, lastDayOfMonth, self, _i, _j, _ref;
      self = this;
      this.$days.empty();
      firstDayOfMonth = this.firstDayOfMonth(this.visibleMonth(), this.visibleYear());
      lastDayOfMonth = this.daysInMonth(this.visibleMonth(), this.visibleYear());
      for (i = _i = 1, _ref = firstDayOfMonth - 1; _i <= _ref; i = _i += 1) {
        this.$days.append($("<li class='drp-day drp-day-empty'></li>"));
      }
      for (i = _j = 1; _j <= lastDayOfMonth; i = _j += 1) {
        this.$days.append($("<li class='drp-day " + (this.dayClass(i, firstDayOfMonth, lastDayOfMonth)) + "'>" + i + "</li>"));
      }
      return this.$calendar.find('.drp-day').click(function(evt) {
        var day;
        if ($(this).hasClass('drp-day-disabled')) {
          return false;
        }
        day = parseInt($(this).text(), 10);
        if (isNaN(day)) {
          return false;
        }
        return self.setDay(day);
      });
    };

    Calendar.prototype.drawDateDisplay = function() {
      return this.$dateDisplay.text([this.month(), this.day(), this.year()].join('/'));
    };

    Calendar.prototype.month = function() {
      return this.date.getMonth() + 1;
    };

    Calendar.prototype.day = function() {
      return this.date.getDate();
    };

    Calendar.prototype.dayOfWeek = function() {
      return this.date.getDay() + 1;
    };

    Calendar.prototype.year = function() {
      return this.date.getFullYear();
    };

    Calendar.prototype.visibleMonth = function() {
      return this._visibleMonth;
    };

    Calendar.prototype.visibleYear = function() {
      return this._visibleYear;
    };

    Calendar.prototype.nameOfMonth = function(month) {
      return MONTHS[month - 1];
    };

    Calendar.prototype.firstDayOfMonth = function(month, year) {
      return new Date(year, month - 1, 1).getDay() + 1;
    };

    Calendar.prototype.daysInMonth = function(month, year) {
      month || (month = this.visibleMonth());
      year || (year = this.visibleYear());
      return new Date(year, month, 0).getDate();
    };

    return Calendar;

  })();

  $.fn.dateRangePicker = function() {
    return new DateRangePicker(this);
  };

  $('.custom-date').dateRangePicker();
}).call(this);
