(function() {
  Polymer({
    ready: function() {},
    onSelect: function() {
      this.date.selected = true;
      this.fire('selected', this.date);
    }
  });

}).call(this);
