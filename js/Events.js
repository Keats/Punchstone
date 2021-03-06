// Generated by CoffeeScript 1.3.3
(function() {
  var Events,
    __indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

  P.Events = {};

  Events = {
    addEventListener: function(type, callback) {
      var events;
      events = this["_events"] = this["_events"] || {};
      events[type] = events[type] || [];
      return events[type].push(callback);
    },
    removeEventListener: function(type, callback) {
      var events, index;
      events = this["_events"];
      if (__indexOf.call(events[type], callback) >= 0) {
        index = events[type].indexOf(callback);
        return events[type].splice(index, 1);
      }
    },
    hasEventListeners: function(type) {
      return (this["_events"] != null) && (this["_events"][type] != null) && this["_events"][type].length > 0;
    },
    fireEvent: function(type, data) {
      var callback, _i, _len, _ref, _results;
      if (!this.hasEventListeners(type)) {
        return this;
      }
      _ref = this["_events"][type];
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        callback = _ref[_i];
        _results.push(callback.call(this, data));
      }
      return _results;
    }
  };

  P.Events = Events;

}).call(this);
